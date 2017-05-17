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

  def update_quality
    @items.each do |item|
      case item
      when 'normal'
        return update_normal(item)
      end

      if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert"
        if item.quality > 0
          if item.name != "Sulfuras, Hand of Ragnaros"
            item.quality = item.quality - 1
          end
        end
      else
        if item.quality < 50
          item.quality = item.quality + 1
          if item.name == "Backstage passes to a TAFKAL80ETC concert"
            if item.sell_in < 11
              if item.quality < 50
                item.quality = item.quality + 1
              end
            end
            if item.sell_in < 6
              if item.quality < 50
                item.quality = item.quality + 1
              end
            end
          end
        end
      end
      if item.name != "Sulfuras, Hand of Ragnaros"
        @update_sell_in.update(item)
      end
      if item.sell_in < 0
        if item.name != "Aged Brie"
          if item.name != "Backstage passes to a TAFKAL80ETC concert"
            if item.quality > 0
              if item.name != "Sulfuras, Hand of Ragnaros"
                item.quality = item.quality - 1
              end
            end
          else
            item.quality = item.quality - item.quality
          end
        else
          if item.quality < 50
            item.quality = item.quality + 1
          end
        end
      end
    end
  end
end
