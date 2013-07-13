module Gnunet::Cli

  class BaseCommand

    def self.match?(line)
      line =~ /^#{cmd}/
    end

    def initialize(line)
      parse(line)
    end

    def execute(con)
      con.send_data msg.pack
    end
  end
end
