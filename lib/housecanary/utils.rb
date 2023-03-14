# frozen_string_literal: true

module Housecanary
  module Utils # :nodoc:
    def deep_symbolize_keys(hash)
      deep_transform_keys(hash) { |key|
        begin
          key.to_sym
        rescue
          key
        end
      }
    end
    module_function :deep_symbolize_keys

    private

    def deep_transform_keys(object, &block)
      case object
      when Hash
        object.each_with_object({}) do |(key, value), result|
          result[yield(key)] = deep_transform_keys(value, &block)
        end
      when Array
        object.map { |e| deep_transform_keys(e, &block) }
      else
        object
      end
    end
    module_function :deep_transform_keys
  end
end
