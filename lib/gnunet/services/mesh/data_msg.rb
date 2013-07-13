module Gnunet
  module Services
    module Mesh
      class DataMsg < ::Gnunet::GnuMessage

        add_field :tid, :u32
        add_field :data,:string,:length => false

        #TID of the tunnel
        attr_accessor :tid
        attr_accessor :data #something

        def type
          275
        end


      end
    end
  end
end
