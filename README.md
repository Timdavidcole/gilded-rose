# Gilded Rose Refactoring Kata

- So this is my attempt at the great Gilded Rose!  Decided to do it in Ruby, with which I'm most comfortable with OOP.

- I really enjoyed it, didn't actually find it too hard, but that's maybe because I haven't refactored it well enough :P.

## My Approach

- Wrote a full passing testing suite for the original code in rspec.  Had feature tests, and a couple unit tests for the item class.
- Used these to check I wasn't breaking anything.
- Initially tried to refactor our a update_quality and update_sell_in method in GildedRose class, then realised something far more drastic would be needed!
- Class inheritance seemed like the way to go if I want to keep the Item class intact.  This just meant I could create a raft of specific item classes with their own .update_quality and .update_sell_in methods which I could "polymorphically" call in Gilded Rose.
```
class GildedRose
  attr_reader :items

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      item.updates_quality
      item.updates_sell_in
    end
  end
end
```
- Which is what I did!  And it all seems to work well, and far more legibly than the massive raft of if/else statements before.
```
class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end

class AgedBrie < Item
  def updates_quality
    @quality += 1
    @quality = 50 if @quality > 50
  end

  def updates_sell_in
    @sell_in -= 1
  end
end
```
- My only reservations is now you have to instantiate the specific class of item rather than just Item.new.  But there was nothing in the brief that said you couldn't do this.  Just to keep the functionality and not change item class. Like this:
```
AgedBrie.new('Aged Brie', 2, 0),
Other.new('Elixir of the Mongoose', 5, 7),
Sulfuras.new('Sulfuras, Hand of Ragnaros', 0, 80),
BackstagePasses.new('Backstage passes to a TAFKAL80ETC concert', 5, 49),
Conjured.new('Conjured Mana Cake', 3, 6)
```
- Although could easily make a little Item class method that examines the name string and picks the right one though.  
- It also doesn't check for edge cases or raise any errors, but again, they don't ask for this so I didn't put it in!
