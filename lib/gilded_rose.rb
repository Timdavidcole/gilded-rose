# frozen_string_literal: true

require_relative './item.rb'

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
