# frozen_string_literal: true
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
    @quality += 1 unless @quality == 50
  end

  def updates_sell_in
    @sell_in -= 1
  end

end

class Sulfuras < Item

  def updates_quality
    return
  end

  def updates_sell_in
    return
  end

end

class BackstagePasses < Item

  def updates_quality
    if @sell_in < 0
      @quality = 0
    elsif @sell_in < 6
      @quality += 3
    elsif @sell_in < 11
      @quality += 2
    end
  end

  def updates_sell_in
    @sell_in -= 1
  end

end

class Other < Item

  def updates_quality
    if @quality >= 0
      @sell_in < 0 ? @quality -= 2 : @quality -= 1
      if @quality < 0
        @quality = 0
      end
    end
  end

  def updates_sell_in
    @sell_in -= 1
  end

end
