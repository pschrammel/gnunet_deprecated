module Gnunet
  module Services
    module Dht
      class GetMsg
        attr_accessor :size
        attr_accessor :type
        attr_accessor :options
        attr_accessor :desired_replication_level
        attr_accessor :block_type #8 on put = nocheck /0 on get = everything
        attr_accessor :unique_id
        attr_accessor :key
      end
    end
  end
end
