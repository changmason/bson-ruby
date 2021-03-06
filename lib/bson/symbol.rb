# encoding: utf-8
module BSON

  # Injects behaviour for encoding and decoding symbol values to and from
  # raw bytes as specified by the BSON spec.
  #
  # @note Symbols are deprecated in the BSON spec, but they are still
  #   currently supported here for backwards compatibility.
  #
  # @see http://bsonspec.org/#/specification
  #
  # @since 2.0.0
  module Symbol

    # A symbol is type 0x0E in the BSON spec.
    #
    # @since 2.0.0
    BSON_TYPE = 14.chr.force_encoding(BINARY).freeze

    # Get the symbol as encoded BSON.
    #
    # @example Get the symbol as encoded BSON.
    #   :test.to_bson
    #
    # @return [ Symbol ] The encoded symbol.
    #
    # @see http://bsonspec.org/#/specification
    #
    # @since 2.0.0
    def to_bson(encoded = ''.force_encoding(BINARY))
      to_s.to_bson(encoded)
    end

    # Get the symbol as an encoded C symbol.
    #
    # @example Get the symbol as an encoded C symbol.
    #   "test".to_bson_cstring
    #
    # @return [ Symbol ] The encoded symbol.
    #
    # @see http://bsonspec.org/#/specification
    #
    # @since 2.0.0
    def to_bson_cstring(encoded = ''.force_encoding(BINARY))
      to_s.to_bson_cstring(encoded)
    end

    module ClassMethods
      # Deserialize a symbol from BSON.
      #
      # @param [ BSON ] bson The bson representing a symbol.
      #
      # @return [ Regexp ] The decoded symbol.
      #
      # @see http://bsonspec.org/#/specification
      #
      # @since 2.0.0
      def from_bson(bson)
        bson.read(*bson.read(4).unpack(Int32::PACK)).from_bson_string.chop!.intern
      end
    end

    # Register this type when the module is loaded.
    #
    # @since 2.0.0
    Registry.register(BSON_TYPE, ::Symbol)
  end

  # Enrich the core Symbol class with this module.
  #
  # @since 2.0.0
  ::Symbol.send(:include, Symbol)
  ::Symbol.send(:extend, Symbol::ClassMethods)
end
