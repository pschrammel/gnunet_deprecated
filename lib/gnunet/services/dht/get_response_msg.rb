module Gnunet
  module Services
    module Dht
      class GetResponseMsg < ::Gnunet::GnuResponseMessage
        def self.match?(type)
          type == 150
        end

        add_field :block_type, :u32
        add_field :put_path_length, :u32
        add_field :get_path_length, :u32
        add_field :unique_id, :u64
        add_field :expiration, :timestamp #of the put
        add_field :key,:string,:length => 512/8
        add_field :put_path, :id_array, :length => :put_path_length #length = 64 (id size) * put_path_length
        add_field :get_path, :id_array, :length => :get_path_length #length = 64 (id size) * get_path_length
        add_field :data, :string, :length => false


        attr_accessor :reserved
        attr_accessor :unique_id #64

      end
    end
  end
end