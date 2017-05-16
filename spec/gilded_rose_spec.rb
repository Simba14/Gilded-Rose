require 'gilded_rose'
require 'item'

describe GildedRose do

  def item_list(name: 'normal', sell_in: 1, quality: 50)
    @item = Item.new(name, sell_in, quality)
    @items = [@item]
  end

  describe '#update_quality' do
    context 'item is a normal good' do
      before do
        item_list
        @stock = described_class.new(@items)
      end

      it 'name does not change' do
        @stock.update_quality
        expect(@item.name).to eq 'normal'
      end

      it 'items sell in value falls by one' do
        @stock.update_quality
        expect(@item.sell_in).to equal 0
      end
    end
  end

end
