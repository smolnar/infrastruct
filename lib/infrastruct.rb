require 'thread'
require 'infrastruct/version'
require 'infrastruct/manager'
require 'infrastruct/runner'
require 'infrastruct/blocking_queue'
require 'infrastruct/thread_pool'

module Infrastruct
  def create
    runner = Infrastruct::Runner.new(self)
    pool = Infrastruct::ThreadPool.new(runner, threads: options[:threads])

    Manager.new(pool)
  end

  def options(options = {})
    @options ||= { threads: 25 }

    @options.merge(options)

    @options
  end
end
