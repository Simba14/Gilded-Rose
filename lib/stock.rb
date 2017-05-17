require_relative './item'
require_relative './update_sell_in'
require_relative './normal_item'
require_relative './aged_brie'
require_relative './backstage_pass'
require_relative './conjured'
# Not sure yet
class Stock
  def initialize(items:)
    @items = items
  end

  def update_quality
    @items.each do |item|
      case item.name
      when 'normal'
        normal = NormalItem.new
        normal.update(item)
      when 'Aged Brie'
        brie = AgedBrie.new
        brie.update(item)
      when 'Backstage passes to a TAFKAL80ETC concert'
        backstage_pass = BackstagePass.new
        backstage_pass.update(item)
      when 'Conjured'
        conjured = Conjured.new
        conjured.update(item)
      when 'Sulfuras, Hand of Ragnaros'
        break
      end
    end
  end
end
