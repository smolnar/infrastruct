module Infrastruct
  class Runner
    def initialize(factory)
      @factory = factory
      @results = Array.new
      @mutex = Mutex.new
    end

    def perform(args)
      worker = @factory.new
      result = worker.perform(*args)

      @mutex.synchronize { @results << result }
    end

    def collect
      worker = @factory.new

      @mutex.synchronize { worker.collect(@results) }
    end
  end
end
