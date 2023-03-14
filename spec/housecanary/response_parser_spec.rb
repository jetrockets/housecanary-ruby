# frozen_string_literal: true

require 'spec_helper'
require 'housecanary/response_parser'

RSpec.describe Housecanary::ResponseParser do
  subject(:parser) { described_class }

  let(:success_body) { File.new('spec/support/success_geocode_response_body.txt').read }
  let(:error_body) { File.new('spec/support/unauthorized_response_body.txt').read }
  let(:api_error_body) { File.new('spec/support/no_content_response_body.txt').read }
  let(:uri) { 'https://api.housecanary.com/' }

  def setup_response(code, body)
    HTTP::Response.new(
      status: code,
      version: '1.1',
      headers: {},
      body: JSON.parse(body),
      uri: uri
    )
  end

  describe '#perform' do
    context 'Success Response' do
      let(:success_response) { setup_response(200, success_body) }
      let(:result) { parser.perform(success_response) }

      it 'returns body' do
        expect(result).not_to be_nil
      end

      it 'returns body as symbolized hash' do
        expect(result.first).to be_an_instance_of(Hash)
        expect(result.first.key?(:address_info)).to be(true)
      end
    end

    describe 'Error Handling' do
      context 'when response code different from OK' do
        let(:error_response) { setup_response(401, error_body) }

        it 'raises error with message according to code' do
          expect { parser.perform(error_response) }.to raise_error(Housecanary::Error::Unauthorized, a_string_ending_with('Not Authenticated'))
        end
      end

      context 'if response code is OK but API :api_code different from 0' do
        let(:error_response) { setup_response(200, api_error_body) }

        it 'raises error with message according to code' do
          expect { parser.perform(error_response) }.to raise_error(Housecanary::Error::NoContent, a_string_ending_with('no content'))
        end
      end
    end
  end
end
