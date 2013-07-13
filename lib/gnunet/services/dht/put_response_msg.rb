module Gnunet
  module Services
    module Dht
      class PutResponseMsg < Gnunet::GnuResponseMessage
        def self.unpack(str)
          size, type, reserved, unique_id = str.unpack("nnNQ")
          new(:size => size, :type => type, :reserved => reserved, :unique_id => unique_id)
        end

        add_field :reserved, :u32
        add_field :unique_di, :u64

        attr_accessor :reserved
        attr_accessor :unique_id #64

      end
    end
  end
end