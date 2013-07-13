module Gnunet
  class GnuResponseMessage < GnuBaseMessage

    attr_accessor :size
    attr_accessor :type

    def self.unpack(str)
      new(unpack_fields(str))
    end

    #resturn a hash
    def self.unpack_fields(msg)
      result={}

      field_store.inject(msg) do |msg, field|
        #p "unpacking #{msg.inspect} -> #{field.name}"
        value, msg=field.unpack(msg)
        result[field.name]=value
        msg
      end
      result
    end

  end
end