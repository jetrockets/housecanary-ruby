# frozen_string_literal: true

require 'housecanary/api/helpers'
require 'housecanary/api/sales_history'

module Housecanary
  module API
    class Repository
      include Housecanary::API::Helpers
      include Housecanary::AutoInject['connection', 'response_parser']

      SALES_HISTORY_PATH = 'property/sales_history'

      def sales_history(params = {})
        if (response = perform_response(:get, SALES_HISTORY_PATH, params))
          SalesHistory.new(response&.first&.fetch(:'property/sales_history', nil))
        end
      end

      private

      def perform_response(method, path, params = {})
        _perform_response(response_parser, connection, method, path, params)
      end
    end
  end
end
