module Gnunet
  module Services
    module Dht
      class PutResponseMsg < ::Gnunet::GnuResponseMessage

        add_field :reserved, :u32
        add_field :unique_id, :u64

        attr_accessor :reserved
        attr_accessor :unique_id #64

      end
    end
  end
end