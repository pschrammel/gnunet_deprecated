#create/destroy tunnel to peer_id x80000000 xb0000000 u32, port


#both ways


module Gnunet
  module Services
    module Mesh
      class TunnelMsgCreate < TunnelMsgBase
        def type
          273
        end
      end
    end
  end
end
