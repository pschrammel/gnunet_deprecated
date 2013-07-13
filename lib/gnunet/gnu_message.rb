module Gnunet
  module Services
    class GnuMessage

      #type can be of :u16,:u32,:u64,:string
      def self.add_field(name, type, options={})
        field_store << Field.new(name, type, options)
      end


      def pack
        self.class.pack_fields(self)
      end

      private

      class Field
        attr_reader :name, :type, :default

        def initialize(name, type, options={})
          @name=name.to_s
          @type=type
          @options=options
        end

        def packer
          @packer ||= case @type
                        when :u16
                          lambda { |value| [value].pack('n') }
                        when :u32
                          lambda { |value| [value].pack('N') }
                        when :u64
                          lambda { |value| [value].pack('Q') }
                        when :timestamp
                          lambda { |value| [value].pack('Q') }
                        when :string
                          raise "no length given" unless @options.has_key?(:length)
                          lambda { |value|
                            case
                              when @options[:length] == false
                                value
                              when value.size > @options[:length]
                                raise "too long string #{value.inspect}"
                              else
                                value
                            end
                          }
                        else
                          raise "unknown type: #{type.inspect}"
                      end
        end

        def pack(value)
          packer.call(value)
        end
      end #GnuMessage


      def self.field_store
        @fieldstore ||= [Field.new('size', :u16), Field.new('type', :u16)]
      end

      #packages the known fields
      def self.pack_fields(obj)
        field_store.map do |field|
          field.pack(obj.send(field.name))
        end.join('')
      end

    end
  end

end