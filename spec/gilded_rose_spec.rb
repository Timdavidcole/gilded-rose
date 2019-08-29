# frozen_string_literal: true

require_relative '../lib/gilded_rose.rb'

describe GildedRose do

  describe '#update_quality' do

    context 'other item' do

      it 'does not change the name' do
        items = [Other.new('foo', 0, 0)]
        GildedRose.new(items).update_quality
        expect(items[0].name).to eq 'foo'
      end

      it 'degrades item quality twice as fast once SellIn value reaches 0' do
        items = [Other.new('test', 2, 10)]
        gilded_rose = GildedRose.new(items)
        (0...3).each do |_day|
          gilded_rose.update_quality
        end
        expect(items[0].quality).to eq 6
      end

      it 'never decreases the quality of an item below 0' do
        items = [Other.new('test', 2, 2)]
        gilded_rose = GildedRose.new(items)
        (0...4).each do |day|
          gilded_rose.update_quality
        end
        expect(items[0].quality).to eq 0
      end

    end

    context 'AgedBrie' do

      it 'increases quality the older it gets' do
        items = [AgedBrie.new('Aged Brie', 10, 2)]
        gilded_rose = GildedRose.new(items)
        (0...3).each do |_day|
          gilded_rose.update_quality
        end
        expect(items[0].quality).to eq 5
      end

      it 'never lets the quality of an item be more than 50' do
        items = [AgedBrie.new('Aged Brie', 10, 45)]
        gilded_rose = GildedRose.new(items)
        (0...10).each do |_day|
          gilded_rose.update_quality
        end
        expect(items[0].quality).to eq 50
      end

    end

    context 'Sulfuras' do

      it 'never degrades the quality or sell in date' do
        items = [Sulfuras.new('Sulfuras, Hand of Ragnaros', 10, 45)]
        gilded_rose = GildedRose.new(items)
        (0...10).each do |_day|
          gilded_rose.update_quality
        end
        expect(items[0].quality).to eq 45
      end

    end

    context 'Backstage Passes' do

      it 'increases quality by 2 when 10 days or less' do
        items = [BackstagePasses.new('Backstage passes to a TAFKAL80ETC concert', 12, 20)]
        gilded_rose = GildedRose.new(items)
        (0...4).each do |_day|
          gilded_rose.update_quality
          p 'quality'
          p items[0].quality
          p 'sell_in'
          p items[0].sell_in
        end
        expect(items[0].quality).to eq 28
      end

      it 'increases quality by 3 when 5 days or less' do
        items = [BackstagePasses.new('Backstage passes to a TAFKAL80ETC concert', 10, 20)]
        gilded_rose = GildedRose.new(items)
        (0...6).each do |_day|
          gilded_rose.update_quality
          p 'quality'
          p items[0].quality
          p 'sell_in'
          p items[0].sell_in
        end
        expect(items[0].quality).to eq 36
      end

      it 'drops quality to 0 after 10 days' do
        items = [BackstagePasses.new('Backstage passes to a TAFKAL80ETC concert', 10, 20)]
        gilded_rose = GildedRose.new(items)
        (0...11).each do |_day|
          gilded_rose.update_quality
        end
        expect(items[0].quality).to eq 0
      end

    end

  end
end
