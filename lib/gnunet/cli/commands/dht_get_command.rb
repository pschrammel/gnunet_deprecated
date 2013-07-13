module Gnunet::Cli::Commands
  class DhtGetCommand < Gnunet::Cli::BaseCommand

    def self.cmd
      "dht-get"
    end

    def cmd
      self.class.cmd
    end

    def parse(line)
      line =~ /[^\s]+\s+([^\s]+)/
      @key=$1
    end

    def msg
      Gnunet::Services::Dht::GetMsg.new(:options => 0,
                                            :desired_replication_level => 3,
                                            :unique_id => 3434,
                                            :key => @key
      )
    end
  end
end