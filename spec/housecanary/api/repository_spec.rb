# frozen_string_literal: true

require 'spec_helper'
require 'housecanary/api/helpers'
require 'housecanary/api/repository'

RSpec.describe Housecanary::API::Repository do
  subject(:repo) { Housecanary::API::Repository.new }

  let(:success_body) { File.new('spec/support/success_sales_history_response_body.txt').read }
  let(:connection) { Housecanary.container['connection'] }
  let(:query_params) { { address: '123 Main St', zipcode: '94132' } }
  let(:path) { 'property/sales_history' }


  describe 'sales_history' do
    before do
      stub_request(:get, /sales_history/)
        .to_return(status: 200, body: JSON.parse(success_body), headers: { content_type: 'application/json; charset=utf-8' })
    end

    it 'calls connection with correct params' do
      expect(connection).to receive(:get).with(path, params: query_params).and_call_original
      repo.sales_history(query_params)
    end

    it 'returns sales history object' do
      response = repo.sales_history(query_params)
      expect(response).to be_a Array
    end
  end
end
