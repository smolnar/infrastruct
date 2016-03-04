require 'spec_helper'

RSpec.describe Infrastruct::Manager do
  subject { described_class.new(worker_factory, thread_pool: thread_pool) }

  let(:worker_factory) { double(:worker_factory) }
  let(:thread_pool) { double(:thread_pool) }

  describe '.enqueue' do
    it 'it enqueues params for worker' do
      expect(thread_pool).to receive(:enqueue).with([[1, 2, 3], nil])

      subject.enqueue(1, 2, 3)
    end

    it 'enqueues blocks as well' do
      block = -> { }

      expect(thread_pool).to receive(:enqueue).with([[1, 2, 3], block])

      subject.enqueue(1, 2, 3, &block)
    end
  end

  describe '.run' do
    it 'runs enqueued params for worker and collects worker results' do
      workers = [double(:worker), double(:worker)]

      expect(thread_pool).to receive(:run).and_yield([1])
      allow(worker_factory).to receive(:new).and_return(*workers)

      allow(workers[0]).to receive(:perform).with(1) { 2 }
      expect(workers[1]).to receive(:collect).with([2])

      subject.run
    end

    context 'when worker fails' do
      it 'enqueues params again' do
        workers = [double(:worker), double(:worker)]

        expect(thread_pool).to receive(:run).and_yield([1])
        allow(worker_factory).to receive(:new).and_return(*workers)

        allow(workers[0]).to receive(:perform).with(1) { raise ArgumentError.new }
        expect(thread_pool).to receive(:enqueue).with([1])
        expect(workers[1]).to receive(:collect).with([])

        subject.run
      end
    end
  end
end
