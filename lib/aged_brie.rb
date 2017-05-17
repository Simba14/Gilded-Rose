# updates sell in and quality values for aged brie
class AgedBrie
  def update(item)
    item.sell_in -= 1
    return if item.quality >= 50
    item.quality += 1
    item.quality += 1 if item.sell_in <= 0
  end
end
