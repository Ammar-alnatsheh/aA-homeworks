class LRUCache
  attr_reader :size, :arr
  def initialize(size)
    @size = size
    @arr = []
  end

  def count
    # returns number of elements currently in cache
    @arr.count
  end

  def add(el)
    # adds element to cache according to LRU principle
    if @arr.include?(el)
      @arr.delete(el)
      @arr << el
    elsif count >= @size
      @arr.shift
      @arr << el
    else
      @arr << el
    end
  end

  def show
    # shows the items in the cache, with the LRU item first
    @arr
  end

  private
  # helper methods go here!

end
