require_relative './item'
require_relative './update_sell_in'
# Not sure yet
class Stock
  def initialize(items:, update_sell_in: UpdateSellIn.new)
    @items = items
    @update_sell_in = update_sell_in
  end

  def update_normal(item)
    @update_sell_in.update(item)
    return if item.quality.zero?
    item.quality -= 1
    item.quality -= 1 if item.sell_in <= 0
  end

  def update_aged_brie(item)
    @update_sell_in.update(item)
    return if item.quality >= 50
    item.quality += 1
    item.quality += 1 if item.sell_in <= 0
  end

  def update_backstage_passes(item)
    @update_sell_in.update(item)
    return if item.quality >= 50
    return item.quality = 0 if item.sell_in < 0
    item.quality += 1
    item.quality += 1 if item.sell_in < 11
    item.quality += 1 if item.sell_in < 6
  end

  def update_quality
    @items.each do |item|
      case item.name
      when 'normal'
        return update_normal(item)
      when 'Aged Brie'
        return update_aged_brie(item)
      when 'Backstage passes to a TAFKAL80ETC concert'
        return update_backstage_passes(item)
      when 'Sulfuras, Hand of Ragnaros'
        break
      end
    end
  end
end
