require 'gilded_rose'
require 'item'

describe GildedRose do

  def item_list(name: 'normal', sell_in: 1, quality: 50)
    @item = Item.new(name, sell_in, quality)
    @items = [@item]
  end

  describe '#update_quality' do

    context 'all goods' do
      before do
        item_list(quality: 0)
        @stock = described_class.new(@items)
      end

      it 'the minimum quality value is 0' do
        @stock.update_quality
        expect(@item.quality).to eq 0
      end

      it 'quality value can never be negative' do
        expect { @stock.update_quality }.not_to(change { @item.quality })
      end
    end

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

      it 'before sell by date is reached, quality value decreases by one' do
        expect(@item.quality).to equal 49
      end

      it 'once sell by date is past, quality value decreases by double' do
        @stock.update_quality
        expect(@item.quality).to equal 47
      end

    end
  end

end
