# frozen_string_literal: true

require_relative '../lib/gilded_rose.rb'

describe GildedRose do
  describe '#update_quality' do
    it 'does not change the name' do
      items = [Item.new('foo', 0, 0)]
      GildedRose.new(items).update_quality
      expect(items[0].name).to eq 'foo'
    end

    it 'degrades item quality twice as fast once SellIn value reaches 0' do
      items = [Item.new('test', 2, 10)]
      gilded_rose = GildedRose.new(items)
      (0...3).each do |_day|
        gilded_rose.update_quality
      end
      expect(items[0].quality).to eq 6
    end

    it 'never decreases the quality of an item is below 0' do
      items = [Item.new('test', 2, 2)]
      gilded_rose = GildedRose.new(items)
      (0...4).each do |_day|
        gilded_rose.update_quality
      end
      expect(items[0].quality).to eq 0
    end

    it 'increases Aged Brie quality the older it gets' do
      items = [Item.new('Aged Brie', 10, 2)]
      gilded_rose = GildedRose.new(items)
      (0...3).each do |_day|
        gilded_rose.update_quality
      end
      expect(items[0].quality).to eq 5
    end

    it 'never lets the quality of an item be more than 50' do
      items = [Item.new('Aged Brie', 10, 45)]
      gilded_rose = GildedRose.new(items)
      (0...10).each do |_day|
        gilded_rose.update_quality
      end
      expect(items[0].quality).to eq 50
    end

    it 'never degrades the quality or sell in date of Sulfuras' do
      items = [Item.new('Sulfuras, Hand of Ragnaros', 10, 45)]
      gilded_rose = GildedRose.new(items)
      (0...10).each do |_day|
        gilded_rose.update_quality
      end
      expect(items[0].quality).to eq 45
      expect(items[0].sell_in).to eq 10
    end

    it 'increases quality of Backstage passes by 2 when 10 days or less' do
      items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 10, 20)]
      gilded_rose = GildedRose.new(items)
      (0...4).each do |_day|
        gilded_rose.update_quality
      end
      expect(items[0].quality).to eq 28
      expect(items[0].sell_in).to eq 6
    end

    it 'increases quality of Backstage passes by 3 when 5 days or less' do
      items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 10, 20)]
      gilded_rose = GildedRose.new(items)
      (0...7).each do |_day|
        gilded_rose.update_quality
      end
      expect(items[0].quality).to eq 36
      expect(items[0].sell_in).to eq 3
    end

    it 'drops quality of Backstage passes to 0 after 10 days' do
      items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 10, 20)]
      gilded_rose = GildedRose.new(items)
      (0...11).each do |_day|
        gilded_rose.update_quality
      end
      expect(items[0].quality).to eq 0
      expect(items[0].sell_in).to eq -1
    end
  end
end
