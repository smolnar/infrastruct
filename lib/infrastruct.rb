require 'thread'
require 'infrastruct/version'
require 'infrastruct/manager'
require 'infrastruct/nonblocking_queue'
require 'infrastruct/thread_pool'

module Infrastruct
  def create
    pool = Infrastruct::ThreadPool.new(threads: options[:threads])

    Manager.new(self, thread_pool: pool)
  end

  def options(options = {})
    @options ||= { threads: 5 }

    @options.merge(options)

    @options
  end
end
