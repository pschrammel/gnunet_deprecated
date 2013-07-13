module Gnunet::Cli::Commands
  class DhtPutCommand < Gnunet::Cli::BaseCommand

    def self.cmd
      "dht-put"
    end

    def cmd
      self.class.cmd
    end

    def parse(line)
      line =~ /[^\s]+\s+([^\s]+)\s+(.*)/
      @key=$1
      @data=$2
    end

    def msg
      Gnunet::Services::Dht::PutMsg.new(:options => 0,
                                            :desired_replication_level => 3,
                                            :unique_id => 3434,
                                            :expiration => 0,
                                            :key => @key,
                                            :data => @data
      )
    end
  end
end