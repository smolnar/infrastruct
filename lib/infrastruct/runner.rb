module Infrastruct
  class Runner
    def initialize(factory)
      @factory = factory
    end

    def perform(args)
      worker = @factory.new

      worker.perform(*args)
    end

    def collect(results)
      worker = @factory.new

      worker.collect(results)
    end
  end
end
