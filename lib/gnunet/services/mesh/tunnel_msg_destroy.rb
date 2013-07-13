#create/destroy tunnel to peer_id x80000000 xb0000000 u32, port


#both ways


module Gnunet
  module Services
    module Mesh
      class TunnelMsgDestroy < TunnelMsgBase
        def type
          274
        end
      end
    end
  end
end
