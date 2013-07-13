# when tunnel is ready



module Gnunet
  module Services
    module Mesh
      class AckMsg < ::Gnunet::GnuMessage

        add_field :tunnel_id, :u32

        attr_accessor :tunnel_id


        def type
          286
        end

        def size
          #4 for size and type, 8 for tunnel id
          4+8
        end
      end
    end
  end
end
