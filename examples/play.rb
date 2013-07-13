$: << File.expand_path(File.join(File.dirname(__FILE__),'../lib'))

require 'rubygems'
require 'gnunet'
require 'gnunet/services/dht'







class PutResponseMsg
  def self.unpack(str)
    size, type, reserved, unique_id = str.unpack("nnNQ")
    new(:size => size, :type => type, :reserved => reserved, :unique_id => unique_id)
  end

  def initialize(atts={})
    atts.each_pair do |key, value|
      send("#{key}=", value)
    end
  end

  attr_accessor :size
  attr_accessor :type
  attr_accessor :reserved
  attr_accessor :unique_id #64

  def to_s
    "size: #{size}, type: #{type}, reserved: #{reserved}, id: #{unique_id}"
  end
end


class GnuConnector < EventMachine::Connection
  def post_init
    msg=::Gnunet::Services::Dht::PutMsg.new(:options => 0, :desired_replication_level => 3, :unique_id => 3434, :expiration => 0, :key => 'a'*64,
                   :data => "help!"
    )
    p msg.pack
    send_data msg.pack
  end

  def receive_data(data)
    puts PutResponseMsg.unpack(data)
  end
end

EventMachine.run do
  EventMachine.connect '127.0.0.1', 2095, GnuConnector
end




##
#
#
# open a http port
#class MyClient < Gnunet
#
# def on_dht_put_result
#
# end
# def on_mesh_data(data)
#
# end
#end
#

#MyClient.run
#
#
#
#
#
#
#
#
#
#
#
#
#