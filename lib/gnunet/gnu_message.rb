module Gnunet
  class GnuMessage < GnuBaseMessage

    def pack
      self.class.pack_fields(self)
    end

    #packages the known fields
    def self.pack_fields(obj)
      field_store.map do |field|
        field.pack(obj.send(field.name))
      end.join('')
    end

  end
end