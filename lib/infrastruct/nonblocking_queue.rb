module Infrastruct
  class NonblockingQueue
    def initialize
      @queue = ::Queue.new
    end

    def push(element)
      @queue.push(element)
    end

    def pop
      @queue.pop(true)
    end
  end
end
