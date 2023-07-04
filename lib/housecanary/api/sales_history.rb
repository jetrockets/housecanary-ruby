# frozen_string_literal: true

require 'dry-initializer'
require 'dry-types'

require 'housecanary/api/sale'

module Housecanary
  module API
    class SalesHistory
      extend Dry::Initializer
      option :api_code_description, optional: true
      option :api_code, optional: true
      option :result, type: Dry::Types['coercible.array'].of(Dry.Types.Constructor(Sale) { |args| Sale.new(**args) })
    end
  end
end
