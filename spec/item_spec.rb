# frozen_string_literal: true

require_relative '../lib/item.rb'
require_relative '../lib/items.rb'

describe Item do
  describe '#initialize' do
    it 'initializes with name, sell in and quality' do
      item = Item.new('test', 3, 5)
      expect(item.name).to eq 'test'
      expect(item.sell_in).to eq 3
      expect(item.quality).to eq 5
    end
  end

  describe '#to_s' do
    it 'turns item details into string' do
      item = Item.new('test', 3, 5)
      expect(item.to_s).to eq 'test, 3, 5'
    end
  end
end

describe AgedBrie do
  describe '#updates_quality' do
    it 'increases quality by 1' do
      item = AgedBrie.new('test', 3, 5)
      item.updates_quality
      expect(item.quality).to eq 6
    end

    it 'unless quality is over 50' do
      item = AgedBrie.new('test', 3, 50)
      item.updates_quality
      expect(item.quality).to eq 50
    end
  end

  describe '#updates_sell_in' do
    it 'decreases sell_in by 1' do
      item = AgedBrie.new('test', 3, 50)
      item.updates_sell_in
      expect(item.sell_in).to eq 2
    end
  end
end

describe Sulfuras do
  describe '#updates_quality' do
    it 'does nothing to quality' do
      item = Sulfuras.new('test', 3, 5)
      item.updates_quality
      expect(item.quality).to eq 5
    end
  end

  describe '#updates_sell_in' do
    it 'does nothing to sell_in' do
      item = Sulfuras.new('test', 3, 50)
      item.updates_sell_in
      expect(item.sell_in).to eq 3
    end
  end
end

describe BackstagePasses do
  describe '#updates_quality' do
    it 'increases quality by 1 if sell_in over 10' do
      item = BackstagePasses.new('test', 12, 5)
      item.updates_quality
      expect(item.quality).to eq 6
    end

    it 'increases quality by 2 if sell_in under 11' do
      item = BackstagePasses.new('test', 10, 5)
      item.updates_quality
      expect(item.quality).to eq 7
    end

    it 'increases quality by 3 if sell_in under 6' do
      item = BackstagePasses.new('test', 5, 5)
      item.updates_quality
      expect(item.quality).to eq 8
    end

    it 'sets quality to 0 if sell_in equal 0' do
      item = BackstagePasses.new('test', 0, 50)
      item.updates_quality
      expect(item.quality).to eq 0
    end

    it 'unless quality is over 50' do
      item = BackstagePasses.new('test', 3, 50)
      item.updates_quality
      expect(item.quality).to eq 50
    end
  end

  describe '#updates_sell_in' do
    it 'decreases sell_in by 1' do
      item = BackstagePasses.new('test', 3, 50)
      item.updates_sell_in
      expect(item.sell_in).to eq 2
    end
  end
end

describe Conjured do
  describe '#updates_quality' do
    it 'decreases quality by 2 is sell_in is more than 0' do
      item = Conjured.new('test', 1, 5)
      item.updates_quality
      expect(item.quality).to eq 3
    end

    it 'decreases quality by 4 is sell_in is 0 or less' do
      item = Conjured.new('test', 0, 5)
      item.updates_quality
      expect(item.quality).to eq 1
    end
  end

  describe '#updates_sell_in' do
    it 'decreases sell_in by 1' do
      item = Conjured.new('test', 3, 50)
      item.updates_sell_in
      expect(item.sell_in).to eq 2
    end
  end
end

describe Other do
  describe '#updates_quality' do
    it 'decreases quality by 1 is sell_in is more than 0' do
      item = Other.new('test', 1, 5)
      item.updates_quality
      expect(item.quality).to eq 4
    end

    it 'decreases quality by 2 is sell_in is 0 or less' do
      item = Other.new('test', 0, 5)
      item.updates_quality
      expect(item.quality).to eq 3
    end
  end

  describe '#updates_sell_in' do
    it 'decreases sell_in by 1' do
      item = Other.new('test', 3, 50)
      item.updates_sell_in
      expect(item.sell_in).to eq 2
    end
  end
end
