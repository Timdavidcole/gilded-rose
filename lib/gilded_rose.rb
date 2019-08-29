# frozen_string_literal: true

require_relative './item.rb'

class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      item.updates_sell_in
      item.updates_quality
    end
  end

end
