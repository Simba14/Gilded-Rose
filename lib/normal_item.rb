# Represents a normal item i.e. one that does not have specific behaviours
class NormalItem
  def update(item)
    item.sell_in -= 1
    return if item.quality.zero?
    item.quality -= 1
    item.quality -= 1 if item.sell_in <= 0
  end
end
