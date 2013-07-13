module Gnunet
  module Services
    module Mesh
      class ConnectMsg < ::Gnunet::GnuMessage

        add_field :list_ports, :string, :length => false #Can be anything up to the maximum msg size minus the header. Each port is 4 Bytes.

        attr_accessor :list_ports #Has to be passed as Array

        def type
          272
        end

        def size
          4+list_ports.size
        end
      end
    end
  end
end
