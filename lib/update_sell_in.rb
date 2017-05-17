# Updates item's sell in value
class UpdateSellIn
  def update(item)
    item.sell_in -= 1
  end
end
