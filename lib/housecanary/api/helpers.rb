# frozen_string_literal: true

module Housecanary
  module API
    module Helpers
      def _perform_response(parser, connection, method, path, params = {})
        parser.perform(perform_request(method, connection, path, params))
      end

      def perform_request(method, connection, path, params)
        args = connection, path, params
        case method&.to_sym
        when :get
          perform_get(*args)
        when :post
          perform_post(*args)
        else
          raise NotImplementedError, "Method <#{method}> Not Supported"
        end
      end

      def perform_get(connection, path, params)
        connection.get(path, params: params)
      end

      def perform_post(connection, path, params)
        connection.post(path, json: params)
      end
    end
  end
end
