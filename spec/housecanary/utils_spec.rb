# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Housecanary::Utils do
  subject(:utils) { described_class }

  describe '#deep_symbolize_keys' do
    it 'returns deep symbolized hash' do
      regular_hash = {
        'a' => 1,
        'b' => {'c' => 3, 'd' => 4},
        'e' => [{'f' => 6, 'g' => 7}, {'h' => 8, 'i' => [{'j' => 9}, {'k' => 10}]}]
      }

      symbolized_hash = {
        a: 1,
        b: {c: 3, d: 4},
        e: [{f: 6, g: 7}, {h: 8, i: [{j: 9}, {k: 10}]}]
      }

      expect(utils.deep_symbolize_keys(regular_hash)).to eq(symbolized_hash)
    end
  end
end
