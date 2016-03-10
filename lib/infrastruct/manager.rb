module Infrastruct
  class Manager
    attr_reader :queue

    def initialize(thread_pool)
      @thread_pool = thread_pool

      @thread_pool.run
    end

    def enqueue(*args)
      @thread_pool.enqueue(args)
    end

    def result
      @thread_pool.finalize
    end
  end
end
