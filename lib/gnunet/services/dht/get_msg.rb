module Gnunet
  module Services
    module Dht
      class GetMsg < ::Gnunet::Services::GnuMessage


        add_field :desired_replication_level, :u32
        add_field :block_type,:u32
        add_field :options,:u32
        add_field :unique_id,:u64
        add_field :key,:string,:length => 512

        attr_accessor :options #32 bit
        attr_accessor :desired_replication_level #32 bit
        attr_accessor :unique_id #64 bit
        attr_accessor :key #512 bit

        def initialize(atts={})
          atts.each_pair do |key,value|
            send("#{key}=", value)
          end
        end

        def block_type
          #8 on put = nocheck /0 on get = everything
          0
        end

        def size
          84
        end

        def type
          #32 bit - 143 for client get - s. /src/include/gnunet_protocols.h
          143
        end
      end
    end
  end
end
