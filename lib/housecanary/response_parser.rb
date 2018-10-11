# frozen_string_literal: true

require 'housecanary/error'
require 'housecanary/utils'

module Housecanary
  class ResponseParser #:nodoc:
    class << self
      def perform(response)
        response_body = utils.deep_symbolize_keys(response.parse(:json)) || ''
        error_filter(response.code, response_body)
      end

      private

      def utils
        Housecanary::Utils
      end

      def error(code, body)
        Housecanary::Error::ERRORS_MAP[code]&.from_response(body)
      end

      def error_filter(code, body)
        error = error(code, body)
        raise(error) if error
        body
      end
    end
  end
end
