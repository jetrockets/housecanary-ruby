# frozen_string_literal: true

require 'dry-initializer'
require 'dry-types'

require 'housecanary/api/sale'

module Housecanary
  module API
    class SalesHistory
      extend Dry::Initializer
      option :api_code_description
      option :api_code
      option :result, type: Dry::Types['coercible.array'].of(Sale)
    end
  end
end
