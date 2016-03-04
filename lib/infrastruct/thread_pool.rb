module Infrastruct
  class ThreadPool
    attr_reader :queue

    def initialize(threads:)
      @queue = Infrastruct::NonblockingQueue.new
      @number_of_threads = threads
    end

    def enqueue(args)
      @queue.push(args)
    end

    def run(&block)
      @threads = @number_of_threads.times.map do
        Thread.new do
          begin
            while params = @queue.pop do
              block.call(params)
            end
          rescue ThreadError => error
            raise error unless error.message == 'queue empty'
          end
        end
      end

      @threads.map(&:join)
    end
  end
end
