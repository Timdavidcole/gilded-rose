# frozen_string_literal: true

require_relative './item.rb'

class AgedBrie < Item
  def updates_quality
    @quality += 1
    @quality = 50 if @quality > 50
  end

  def updates_sell_in
    @sell_in -= 1
  end
end

class Sulfuras < Item
  def updates_quality
    nil
  end

  def updates_sell_in
    nil
  end
end

class BackstagePasses < Item
  def updates_quality
    if @sell_in < 1
      @quality = 0
    elsif @sell_in < 6
      @quality += 3
    elsif @sell_in < 11
      @quality += 2
    else
      @quality += 1
    end
    @quality = 50 if @quality > 50
  end

  def updates_sell_in
    @sell_in -= 1
  end
end

class Conjured < Item
  def updates_quality
    if @quality >= 0
      @quality -= @sell_in <= 0 ? 4 : 2
      @quality = 0 if @quality.negative?
    end
  end

  def updates_sell_in
    @sell_in -= 1
  end
end

class Other < Item
  def updates_quality
    if @quality >= 0
      @quality -= @sell_in <= 0 ? 2 : 1
      @quality = 0 if @quality.negative?
    end
  end

  def updates_sell_in
    @sell_in -= 1
  end
end
