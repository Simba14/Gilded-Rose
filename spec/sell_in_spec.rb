require 'update_sell_in'

describe UpdateSellIn do
  subject(:update_sell_in) { described_class.new }
  let(:item) { double :item, sell_in: 1 }

  describe '#update' do
    # it 'decreases the sell in value of an item' do
    #   puts item.sell_in -= 1
    #   expect(update_sell_in.update(item)).to eq 0
    # end
  end
end
