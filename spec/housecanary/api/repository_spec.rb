# frozen_string_literal: true

require 'spec_helper'
require 'housecanary/api/helpers'
require 'housecanary/api/repository'
require 'housecanary/api/sales_history'

RSpec.describe Housecanary::API::Repository do
  subject(:repo) { Housecanary::API::Repository.new }

  let(:success_body) { File.new('spec/support/success_sales_history_response_body.txt').read }
  let(:error_body) { File.new('spec/support/unauthorized_response_body.txt').read }
  let(:connection) { Housecanary.container['connection'] }
  let(:query_params) { { address: '123 Main St', zipcode: '94132' } }
  let(:path) { 'property/sales_history' }


  describe '#sales_history' do
    before do
      stub_request(:get, /sales_history/)
        .to_return(status: 200, body: JSON.parse(success_body), headers: { content_type: 'application/json; charset=utf-8' })
    end

    it 'calls connection with correct params' do
      expect(connection).to receive(:get).with(path, params: query_params).and_call_original
      repo.sales_history(query_params)
    end

    context 'when the api call completed successfully' do
      let(:response) { repo.sales_history(query_params) }
      it 'returns instance of `Housecanary::API::SalesHistory`' do
        expect(response).to be_a Housecanary::API::SalesHistory
      end
      it 'returns `SalesHistory` contains result' do
        expect(response).to respond_to(:result)
        expect(response.result.size).to eq(2)
      end
      it 'returns result contains `Sale`s array' do
        expect(response.result).to all(be_instance_of(Housecanary::API::Sale))
      end
    end

    context 'when the api call failed' do
      before do
        stub_request(:get, /sales_history/)
          .to_return(status: 401, body: JSON.parse(error_body), headers: { content_type: 'application/json; charset=utf-8' })
      end
      it 'raises an error that occurred' do
        expect { repo.sales_history(query_params) }.to raise_error(Housecanary::Error::Unauthorized, a_string_ending_with("Not Authenticated"))
      end
    end
  end
end
