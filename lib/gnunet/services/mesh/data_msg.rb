module Gnunet
  module Services
    module Mesh
      class DataMsg < ::Gnunet::GnuMessage

        add_field :tid, :u32
        add_field :data,:string,:length => false

        #TID of the tunnel
        attr_accessor :tid
        attr_accessor :data

        def type
          275
        end

        def size
          #2 for size, 2 for type, 4 for tid
          8+data.size
        end


      end
    end
  end
end
