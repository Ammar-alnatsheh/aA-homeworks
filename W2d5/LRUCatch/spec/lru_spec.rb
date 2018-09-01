require 'lru.rb'

RSpec.describe 'LRUCache' do
  subject(:lru){LRUCache.new(2)}

  describe "#initialize" do
    it "set up the buket size" do
      expect(lru.size).to eq(2)
    end
  end

  describe "#count" do
    it "count how many elements we have in the catch " do
      lru.add("I walk the line")
      lru.add(5)
      expect(lru.count).to eq(2)
    end
  end

  describe "#add" do
    it "it add item to the catch " do
      lru.add(5)
      expect(lru.arr).to eq([5])
    end
  end
  describe "#add" do
    it "it delete the item from catch if exist " do
      lru.add(5)
      lru.add(5)
      expect(lru.arr).to_not eq([5,5])
    end
  end

  describe "#add" do
    it "it remove the least reacent used according to its size" do
      lru.add(4)
      lru.add(3)
      lru.add(2)
      lru.add(1)
      expect(lru.arr).to eq([2,1])
    end
  end

  describe "#show" do
    it "return array of all elements" do
      lru.add(4)
      lru.add(3)
      expect(lru.show).to eq([4,3])
    end
  end

end
