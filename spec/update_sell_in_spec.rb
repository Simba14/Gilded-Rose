require 'update_sell_in'

describe UpdateSellIn do
  subject(:update_sell_in) { described_class.new }
  let(:item) { Item.new('test', 1, 5) }

  describe '#update' do
    it 'decreases the sell in value of an item' do
      expect(update_sell_in.update(item)).to eq 0
    end
  end
end
