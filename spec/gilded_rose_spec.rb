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
        @stock.update_quality
      end

      it 'name does not change' do
        expect(@item.name).to eq 'normal'
      end

      it 'sell in value falls by one' do
        expect(@item.sell_in).to equal 0
      end

      it 'quality value decreases by one' do
        expect(@item.quality).to equal 49
      end
    end
  end

end
