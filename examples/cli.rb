$: << File.expand_path(File.join(File.dirname(__FILE__), '../lib'))

require 'rubygems'
require 'gnunet'
require 'gnunet/services/dht'
require 'gnunet/cli'

commands=[Gnunet::Cli::Commands::DhtPutCommand, Gnunet::Cli::Commands::DhtGetCommand]
listen_messages=[Gnunet::Services::Dht::PutResponseMsg] #, Gnunet::Services::Dht::GetResponseMsg]

class GnuConnector < EventMachine::Connection
  attr_reader :queue

  def initialize(q, listen_messages)
    @queue = q
    @listen_messages=listen_messages
    this=self


    cb = Proc.new do |command|
      command.execute(this)
      q.pop &cb
    end
    q.pop &cb
  end

  def receive_data(data)
    size, type = data.unpack("nn")
    response_msg=@listen_messages.select do |msg|
      msg.match?(type)
    end.first

    case
      when response_msg
        puts response_msg.unpack(data)
      else
        puts "unknown message type received #{type}"
    end
  end
end

class KeyboardHandler < EM::Connection
  include EM::Protocols::LineText2

  attr_reader :queue, :commands

  def initialize(q, commands)
    @queue = q
    @commands=commands
  end

  def receive_line(line)
    line=line.strip
    command=commands.select do |command|
      command.match?(line)
    end.first
    case
      when command
        @queue.push(command.new(line))
      when line =~ /^quit/
        EM.stop
        exit 0
      else
        puts "unknown command #{line.inspect}"
    end
  end
end


EventMachine.run do
  q = EM::Queue.new
  EventMachine.connect '127.0.0.1', 2095, GnuConnector, q, listen_messages
  EM.open_keyboard(KeyboardHandler, q, commands)
end
