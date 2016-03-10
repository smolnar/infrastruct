module Infrastruct
  class BlockingQueue
    def initialize
      @queue = ::Queue.new
      @mutex = Mutex.new
      @blocking = true
    end

    def push(element)
      @queue.push(element)
    end

    def pop
      @mutex.synchronize do
        @queue.pop(!@blocking)
      end
    end

    def unblock!
      @mutex.synchronize do
        @blocking = false
      end
    end
  end
end
