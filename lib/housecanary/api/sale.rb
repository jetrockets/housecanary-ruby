# frozen_string_literal: true

require 'dry-initializer'
require 'dry-types'

module Housecanary
  module API
    class Sale
      extend Dry::Initializer
      option :amount
      option :apn
      option :event_type
      option :fips
      option :grantee_1_forenames
      option :grantee_1
      option :grantee_2_forenames
      option :grantee_2
      option :grantor_1_forenames
      option :grantor_1
      option :grantor_2
      option :record_book
      option :record_date
      option :record_doc
      option :record_page

      def self.call(*args)
        self.new(*args)
      end
    end
  end
end