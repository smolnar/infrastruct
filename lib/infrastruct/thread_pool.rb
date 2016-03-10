module Infrastruct
  class ThreadPool
    def initialize(runner, threads:)
      @runner = runner
      @number_of_threads = threads
      @queue = Infrastruct::BlockingQueue.new
      @results = Array.new
      @threads = []
    end

    def enqueue(args)
      @queue.push(args)
    end

    def finalize
      @queue.unblock!
      @threads.map(&:join)

      @runner.collect(@results)
    end

    def run
      mutex = Mutex.new

      @threads = @number_of_threads.times.map do |n|
        Thread.new do
          begin
            while args = @queue.pop do
              result = @runner.perform(args)

              mutex.synchronize do
                @results << result
              end
            end
          rescue ThreadError => error
            raise error unless error.message == 'queue empty'
          end
        end
      end
    end
  end
end
