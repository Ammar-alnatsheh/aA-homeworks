class Queue
  attr_reader :root
  def initialize
    @root = []
  end

  def enqueue(el)
    @root.push(el)
    el
  end

  def dequeue
    @root.shift
  end

  def peek
    @root[0]
  end

end
