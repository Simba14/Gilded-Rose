# updates sell in and quality values for conjured items
class Conjured
  def update(item)
    item.sell_in -= 1
    return if item.quality.zero?
    item.quality -= 2
    item.quality -= 2 if item.sell_in <= 0
  end
end
