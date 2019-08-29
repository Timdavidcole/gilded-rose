#!/usr/bin/ruby -w
require_relative '../lib/gilded_rose.rb'

describe GildedRose do

  items = [
    Item.new(name="+10 Dexterity Vest", sell_in=3, quality=6),
    Item.new(name="+5 Dexterity Vest", sell_in=10, quality=20),
    Item.new(name="Aged Brie", sell_in=2, quality=0),
    Item.new(name="Elixir of the Mongoose", sell_in=5, quality=7),
    Item.new(name="Sulfuras, Hand of Ragnaros", sell_in=0, quality=80),
    Item.new(name="Sulfuras, Hand of Ragnaros", sell_in=-1, quality=80),
    Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=15, quality=20),
    Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=10, quality=49),
    Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=5, quality=49),
    # This Conjured item does not work properly yet
    Item.new(name="Conjured Mana Cake", sell_in=3, quality=6), # <-- :O
  ]

  describe "updating items" do
    it "updates original items in 1 day" do
      days = 1
      p items[0].quality
      p items[0].sell_in
      gilded_rose = GildedRose.new(items)
      (0...days).each do |day|
        gilded_rose.update_quality
        p items[0].quality
        p items[0].sell_in
      end
      expect(items[0].quality).to eq 19
      expect(items[0].sell_in).to eq 9
    end
  end

end
