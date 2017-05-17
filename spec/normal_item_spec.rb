require 'normal_item'
describe NormalItem do
  subject(:normal) { described_class.new }
  let(:item) { Item.new('normal', 1, 0) }

  describe '#update' do

    it 'quality unaltered if value is zero' do
      expect { normal.update(item) }.not_to(change { item.quality })
    end
  end
end
