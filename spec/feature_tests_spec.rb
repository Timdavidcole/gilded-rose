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
        (0...4).each do |_day|
          gilded_rose.update_quality
        end
        expect(items[0].quality).to eq 4
      end

      it 'never decreases the quality of an item below 0' do
        items = [Other.new('test', 2, 2)]
        gilded_rose = GildedRose.new(items)
        (0...4).each do |_day|
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
        end
        expect(items[0].quality).to eq 26
      end

      it 'increases quality by 3 when 5 days or less' do
        items = [BackstagePasses.new('Backstage passes to a TAFKAL80ETC concert', 12, 20)]
        gilded_rose = GildedRose.new(items)
        (0...8).each do |_day|
          gilded_rose.update_quality
        end
        expect(items[0].quality).to eq 35
      end

      it 'drops quality to 0 after 10 days' do
        items = [BackstagePasses.new('Backstage passes to a TAFKAL80ETC concert', 12, 20)]
        gilded_rose = GildedRose.new(items)
        (0...13).each do |_day|
          gilded_rose.update_quality
        end
        expect(items[0].quality).to eq 0
      end
    end

    context 'test big list' do
      describe 'updating items' do
        it 'updates items in 2 days' do
          items = [
            Other.new('+10 Dexterity Vest', 3, 6),
            Other.new('+5 Dexterity Vest', 10, 20),
            AgedBrie.new('Aged Brie', 2, 0),
            Other.new('Elixir of the Mongoose', 5, 7),
            Sulfuras.new('Sulfuras, Hand of Ragnaros', 0, 80),
            Sulfuras.new('Sulfuras, Hand of Ragnaros', -1, 80),
            BackstagePasses.new('Backstage passes to a TAFKAL80ETC concert', 15, 20),
            BackstagePasses.new('Backstage passes to a TAFKAL80ETC concert', 10, 49),
            BackstagePasses.new('Backstage passes to a TAFKAL80ETC concert', 5, 49),
            Conjured.new('Conjured Mana Cake', 3, 6)
          ]
          gilded_rose = GildedRose.new(items)
          (0...2).each do |_day|
            gilded_rose.update_quality
          end
          expect(items[9].quality).to eq 2
        end
      end
    end
  end
end
