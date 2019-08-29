# frozen_string_literal: true

require_relative '../lib/gilded_rose.rb'

describe GildedRose do
  it 'initializes with items' do
    gilded_rose = GildedRose.new('items')
    expect(gilded_rose.items).to eq 'items'
  end

  describe '#update_quality' do
    it 'runs methods on items' do
      item = double(:item)
      allow(item).to receive(:updates_quality)
      allow(item).to receive(:updates_sell_in)
      items = [item]
      gilded_rose = GildedRose.new(items)
      expect { gilded_rose.update_quality }.not_to raise_error
    end
  end
end
