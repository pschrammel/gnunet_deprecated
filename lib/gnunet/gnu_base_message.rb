module Gnunet
  class GnuBaseMessage

    def initialize(atts={})
      atts.each_pair do |key, value|
        send("#{key}=", value)
      end
    end

    #type can be of :u16,:u32,:u64,:string
    def self.add_field(name, type, options={})
      field_store << Field.new(name, type, options)
    end

    def to_s
      field_store.map do |field|
        "#{field.name}: #{send(field.name).inspect}"
      end.join('; ')
    end

    private


    def self.field_store
      @fieldstore ||= [Field.new('size', :u16), Field.new('type', :u16)]
    end


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


      def unpacker
        @unpacker ||= case @type
          when :u16
            lambda { |str| [str.unpack('n'), str[2, -1]] }
          when :u32
            lambda { |str| [str.unpack('N'), str[4, -1]] }
          when :u64
            lambda { |str| [str.unpack('Q'), str[8, -1]] }
          when :timestamp
            lambda { |str| [str.unpack('Q'), str[8, -1]] }
          when :string
            raise "no length given" unless @options.has_key?(:length)
            lambda { |str|
              if @options[:length] == false
                [str, ""]
              else
                [str[0..@options[:length]-1], [@options[:length], -1]]
              end
            }
          else
            raise "unknown type: #{type.inspect}"
        end
      end

      def pack(value)
        packer.call(value)
      end

      def unpack(msg)
        unpacker.call(msg)
      end
    end #Field
  end #GnuBaseMessage
end
