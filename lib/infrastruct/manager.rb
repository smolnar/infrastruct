module Infrastruct
  class Manager
    attr_reader :queue

    def initialize(worker_factory, thread_pool:)
      @worker_factory = worker_factory
      @thread_pool = thread_pool
      @results = Array.new
      @mutex = Mutex.new
    end

    def enqueue(*args, &block)
      @thread_pool.enqueue([args, block])
    end

    def run
      @thread_pool.run do |params|
        begin
          worker = @worker_factory.new
          result = worker.perform(*params[0], &params[1])

          @mutex.synchronize do
            @results.push(result)
          end
        rescue
          @thread_pool.enqueue(params)
        end
      end

      worker = @worker_factory.new
      worker.collect(@results)
    end
  end
end
