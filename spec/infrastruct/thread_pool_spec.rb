require 'spec_helper'

RSpec.describe Infrastruct::ThreadPool do
  subject { Infrastruct::ThreadPool.new(runner, threads: 5) }

  let(:runner) { double(:runner) }

  describe '#enqueue' do
    it 'enqueues arguments to queue' do
      expect_any_instance_of(Infrastruct::BlockingQueue).to receive(:push).with([1, 2])

      subject.enqueue([1, 2])
    end
  end

  describe '#run' do
    it 'runs runner and collect results' do
      subject.run

      expect(runner).to receive(:perform).with([1])
      expect(runner).to receive(:perform).with([2])
      expect(runner).to receive(:perform).with([3, 4, 5])
      expect(runner).to receive(:collect)

      subject.enqueue([1])
      subject.enqueue([2])
      subject.enqueue([3, 4, 5])

      subject.finalize
    end
  end
end
