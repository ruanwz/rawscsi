module Rawscsi
  module Stringifier
    class Simple
      include Rawscsi::Stringifier::Encode

      attr_reader :value

      def initialize(value)
        @value = value
      end

      def build
        if value.kind_of?(Hash)
          build_from_hash
        else
          encode(stringify(value))
        end
      end

      private
      def build_from_hash
        if not_hash = value[:not]
          "(not" + encode(" #{stringify(not_hash)}") + ")"
        elsif pre_hash = value[:prefix]
          "(prefix" + encode(" #{stringify(pre_hash, true)}") + ")"
        elsif range = value[:range]
          range
        else
          encode(stringify(value))
        end
      end

      def stringify(value, prefix=false)
        output_str = ""
        if value.kind_of?(Hash)
          value.each do |k,v|
            output_str << kv_stringify(k, v, prefix)
          end
        else
          output_str <<  "'#{value.to_s}'"
        end
        output_str
      end

      def kv_stringify(k, v, prefix=false) 
        if prefix
          "field=#{k} '#{v}'"
        else
          "#{k}:'#{v}'"
        end
      end
    end
  end
end

