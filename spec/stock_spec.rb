require 'stock'
require 'item'

describe Stock do

  # let(:sell_in) { SellIn.new }

  describe '#update_quality' do
    context 'all goods' do
      before do
        item_list(quality: 0)
        @stock = described_class.new(items: @items)
        @stock.update_quality
      end

      it 'name does not change' do
        expect(@item.name).to eq 'normal'
      end

      it 'the minimum quality value is 0' do
        expect(@item.quality).to eq 0
      end

      it 'quality value can never be negative' do
        expect { @stock.update_quality }.not_to(change { @item.quality })
      end

      it 'sell in value falls by one' do
        expect(@item.sell_in).to equal 1
      end

      it 'sell in value can be negative' do
        @stock.update_quality
        @stock.update_quality
        expect(@item.sell_in).to equal(-1)
      end
    end

    context 'item is a normal good' do
      before do
        item_list
        @stock = described_class.new(items: @items)
        @stock.update_quality
      end

      it 'before sell by date is reached, quality value decreases by 1' do
        expect(@item.quality).to equal 49
      end

      it 'once sell by date is past, quality value falls by 2' do
        @stock.update_quality
        expect(@item.quality).to equal 47
      end
    end

    context "item is 'Aged Brie'" do
      context 'before sell by date is reached' do
        before do
          item_list(name: 'Aged Brie', quality: 49)
          @stock = described_class.new(items: @items)
          @stock.update_quality
        end

        it 'quality value increases by 1 with time' do
          expect(@item.quality).to eq 50
        end

        it 'quality value cannot exceed 50' do
          expect { @stock.update_quality }.not_to(change { @item.quality })
        end
      end

      context 'once sell by date is past' do
        before { item_list(name: 'Aged Brie', quality: 10, sell_in: 0)}
        it 'quality increases by 2 with time' do
          @stock = described_class.new(items: @items)
          @stock.update_quality
          expect(@item.quality).to eq 12
        end
      end
    end

    context "item is 'Sulfuras, Hand of Ragnaros'" do
      before do
        item_list(name: 'Sulfuras, Hand of Ragnaros', quality: 80)
        @stock = described_class.new(items: @items)
      end

      it 'sell in value does not change' do
        expect { @stock.update_quality }.not_to(change { @item.sell_in })
      end

      it 'quality value is constant at 80' do
        @stock.update_quality
        expect(@item.quality).to eq 80
      end
    end

    context "item is 'Backstage passes to a TAFKAL80ETC concert'" do
      before do
        item_list(name: 'Backstage passes to a TAFKAL80ETC concert', quality: 40, sell_in: 10)
        @stock = described_class.new(items: @items)
      end

      context 'before sell by date is reached' do
        it 'quality value increase by 2 once sell in date is lower than 11 days' do
          @stock.update_quality
          expect(@item.quality).to eq 42
        end

        it 'quality value increase by 3 once sell in date is lower than 6 days' do
          @item.sell_in = 5
          @stock.update_quality
          expect(@item.quality).to eq 43
        end
      end

      context 'once sell by date is past' do
        it 'quality value is 0' do
          @item.sell_in = 0
          @stock.update_quality
          expect(@item.quality).to eq 0
        end
      end
    end

    context 'item is conjured' do
      before do
        item_list(name: 'Conjured')
        @stock = described_class.new(items: @items)
        @stock.update_quality
      end

      it 'before sell by date is reached, quality value decreases by 2' do
        expect(@item.quality).to equal 48
      end

      it 'once sell by date is past, quality value falls by 4' do
        @stock.update_quality
        expect(@item.quality).to equal 44
      end
    end
  end

  def item_list(name: 'normal', sell_in: 2, quality: 50)
    @item = Item.new(name, sell_in, quality)
    @items = [@item]
  end

end
