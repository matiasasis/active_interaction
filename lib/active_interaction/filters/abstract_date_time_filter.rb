# coding: utf-8

module ActiveInteraction
  # @private
  class AbstractDateTimeFilter < Filter
    def cast(value)
      case value
      when klass
        value
      when String
        begin
          if has_format?
            klass.strptime(value, format)
          else
            klass.parse(value)
          end
        rescue ArgumentError
          super
        end
      else
        super
      end
    end

    private

    def format
      options.fetch(:format)
    end

    def has_format?
      options.key?(:format)
    end

    def klass
      fail NotImplementedError
    end
  end
end
