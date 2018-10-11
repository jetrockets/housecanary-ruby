# frozen_string_literal: true

require 'housecanary/error'
require 'housecanary/utils'

module Housecanary
  class ResponseParser #:nodoc:
    class << self
      def perform(response)
        response_body = response ? utils.deep_symbolize_keys(response.parse(:json)) : ''
        api_error_filter(response.code, response_body)
      end

      private

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
