# frozen_string_literal: true

require 'spec_helper'
require 'housecanary/error'
require 'housecanary/connection'
require 'housecanary/response_parser'

describe Housecanary::Error do
  let(:connection) { Housecanary::Connection.new(api_key: 'my_api_key', api_secret: 'my_api_secret') }
  let(:response_parser) { Housecanary::ResponseParser }

  describe '#code' do
    it 'returns the error code' do
      error = Housecanary::Error.new('Some Exception Happened', 123)
      expect(error.code).to eq(123)
    end
  end

  describe '#message' do
    it 'returns the error message' do
      msg = 'Some Awful happened'
      error = Housecanary::Error.new(msg)
      expect(error.message).to eq(msg)
    end
  end

  Housecanary::Error::ERRORS_MAP.each do |status, exception|
    context "when HTTP status is #{status}" do
      it "raises #{exception}" do
        path = 'property/census'

        stub_request(:get, Housecanary::Connection::BASE_URL + 'property/census')
          .to_return(status: status, body: '{}', headers: { content_type: 'application/json; charset=utf-8' })

        expect { response_parser.perform(connection.get(path)) }.to raise_error(exception)
      end
    end
  end
end
