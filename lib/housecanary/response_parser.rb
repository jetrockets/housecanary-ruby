# frozen_string_literal: true

require 'housecanary/error'
require 'housecanary/utils'

module Housecanary
  class ResponseParser #:nodoc:
    class << self
      def perform(response)
        response_body = parse_body(response)
        code = parse_code(response.code, response_body)
        api_error_filter(code, response_body)
      end

      private

      def parse_body(response)
        response.body.empty? ? '' : utils.deep_symbolize_keys(response.parse(:json))
      end

      def parse_code(code, body = {})
        return code unless code.to_s.to_i == 200
        api_code = body.dig(:api_code) if body.is_a?(Hash)
        return api_code unless api_code.to_s.to_i.zero?
        code
      end

      def utils
        Housecanary::Utils
      end

      def error(code, body)
        Housecanary::Error::ERRORS_MAP[code]&.from_response(body)
      end

      def api_error_filter(code, body)
        error = error(code, body)
        raise(error) if error
        body
      end
    end
  end
end
