# [Gilded Rose Refactoring Kata](https://github.com/emilybache/GildedRose-Refactoring-Kata)

- So this is my attempt at cleaning up the great [Gilded Rose](https://github.com/emilybache/GildedRose-Refactoring-Kata)!  Decided to do it in Ruby, with which I'm most comfortable doing OOP.

- I really enjoyed it, didn't actually find it too hard, but that's maybe because I haven't refactored it well enough :P.

## My Approach

- Wrote a full passing testing suite for the original code in rspec.  Had feature tests, and a couple unit tests for the item class. Used these to check I wasn't breaking any functionality.
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
- I think I could fairly easily make a little Item class method that examines the name string and picks the right one though. Which I might well do if I've got time. 
- Currently it also doesn't check for edge cases or raise any errors, but again, they don't ask for this so I didn't put it in!
- Another way to do this could have been using polymorphic class methods, searching the beginning of each Item.name string, and entering that as a class.  But that would still make a long line of conditionals in GuildRose.update_quality which is less legible.  So yeah, different strokes for different folks.  ;P

## Installation

You can install and run if you REALLY want to by

```
git clone git@github.com:Timdavidcole/guilded-rose.git
cd gilded-rose
bundle install
irb
require './lib/gilded_rose.rb'
```
But I'd recommend just having a rummage around the files, as no methods of note return anything. :)
