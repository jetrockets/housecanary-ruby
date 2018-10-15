# frozen_string_literal: true

require 'dry-initializer'
require 'dry-types'

module Housecanary
  module API
    class Sale
      extend Dry::Initializer
      option :amount
      option :apn, optional: true
      option :event_type, optional: true
      option :fips, optional: true
      option :grantee_1_forenames
      option :grantee_1
      option :grantee_2_forenames, optional: true
      option :grantee_2, optional: true
      option :grantor_1_forenames
      option :grantor_1
      option :grantor_2, optional: true
      option :record_book, optional: true
      option :record_date, optional: true
      option :record_doc, optional: true
      option :record_page, optional: true

      def self.call(*args)
        self.new(*args)
      end
    end
  end
end