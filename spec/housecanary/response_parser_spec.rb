# frozen_string_literal: true

require 'spec_helper'
require 'housecanary/response_parser'

RSpec.describe Housecanary::ResponseParser do
  subject { Housecanary::ResponseParser }
  let(:success_body)  { File.new('spec/support/success_geocode_response_body.txt').read }
  let(:error_body)    { File.new('spec/support/unauthorized_response_body.txt').read }
  let(:uri)           { 'https://api.housecanary.com/' }
  let(:headers)       { {} }

  let(:success_response) do
    HTTP::Response.new(
      :status  => 200,
      :version => "1.1",
      :headers => headers,
      :body    => JSON.parse(success_body),
      :uri     => uri
    )
  end
  let(:error_response) do
    HTTP::Response.new(
      :status  => 401,
      :version => "1.1",
      :headers => headers,
      :body    => JSON.parse(error_body),
      :uri     => uri
    )
  end
  describe '#perform' do
    context 'Success Response' do
      let(:result) { subject.perform(success_response) }
      it 'returns body' do
        expect(result).not_to eq(nil)
      end

      it 'returns body as symbolized hash' do
        expect(result.first).to be_an_instance_of(Hash)
        expect(result.first.has_key?(:address_info)).to eq(true)
      end
    end

    context 'Error Response' do
      it 'raises error according to code' do
        expect{ subject.perform(error_response) }.to raise_error(Housecanary::Error::Unauthorized, a_string_ending_with("Not Authenticated"))
      end
    end
  end
end
