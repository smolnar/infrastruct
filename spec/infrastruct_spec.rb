require 'spec_helper'

class SquaredNumbersCollector
  extend Infrastruct

  def perform(number)
    number ** 2
  end

  def collect(numbers)
    numbers.inject(&:+)
  end
end

RSpec.describe Infrastruct do
  describe '.create' do
    it 'creates manager and runs infrastructure' do
      worker = SquaredNumbersCollector.create

      worker.enqueue(1)
      worker.enqueue(2)
      worker.enqueue(3)

      sum = worker.result

      expect(sum).to eql(14)
    end
  end
end
