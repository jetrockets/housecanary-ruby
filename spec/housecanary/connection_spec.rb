# frozen_string_literal: true

require 'spec_helper'
require 'housecanary/connection'

describe Housecanary::Connection do
  subject(:connection) do
    Housecanary.container['connection']
  end

  let(:success_body) { File.new('spec/support/success_geocode_response_body.txt').read }
  let(:url) { Housecanary::Connection::BASE_URL + 'property/geocode' }

  describe '#get' do
    before do
      stub_request(:get, url).to_return(body: success_body, status: 200)
    end

    it { expect(connection).to respond_to(:get) }

    it 'returns an instance of `HTTP::Response`' do
      expect(connection.get(url)).to be_an_instance_of(HTTP::Response)
    end

    it 'returns response with body' do
      expect(connection.get(url).body.to_s).to eq success_body
    end
  end

  describe '#post' do
    before do
      stub_request(:post, url)
        .to_return(status: 200, body: success_body, headers: {content_type: 'application/json; charset=utf-8'})
    end

    it { expect(connection).to respond_to(:post) }

    it 'returns an instance of `HTTP::Response`' do
      expect(connection.post(url, json: [])).to be_an_instance_of(HTTP::Response)
    end

    it 'returns response with body' do
      expect(connection.post(url).body.to_s).to eq success_body
    end
  end
end
