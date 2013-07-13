#create/destroy tunnel to peer_id x80000000 xb0000000 u32, port


#both ways


module Gnunet
  module Services
    module Mesh
      class TunnelMsgBase < ::Gnunet::GnuMessage


        add_field :tunnel_id, :u32
        add_field :peer,:string,:length => 512/8
        add_field :port, :u32
        add_field :options, :u32

        # Type for tunnel numbering.
        # - Local tunnel numbers given by the service (incoming) are >= 0xB0000000
        # - Local tunnel numbers given by the client (created) are >= 0x80000000
        # - Global tunnel numbers are < 0x80000000
        attr_accessor :tunnel_id #32 bit

        attr_accessor :peer #512 bit
        attr_accessor :options #32
        attr_accessor :port #32

        def initialize(atts={})
          atts.each_pair do |key,value|
            send("#{key}=", value)
          end
        end

        def size
          80
        end
      end
    end
  end
end
