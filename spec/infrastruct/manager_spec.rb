require 'spec_helper'

RSpec.describe Infrastruct::Manager do
  subject { described_class.new(thread_pool) }

  let(:thread_pool) { double(:thread_pool) }

  before :each do
    expect(thread_pool).to receive(:run)
  end

  describe '#enqueue' do
    it 'it enqueues params for worker' do
      expect(thread_pool).to receive(:enqueue).with([1, 2, 3])

      subject.enqueue(1, 2, 3)
    end

    it 'enqueues blocks as well' do
      expect(thread_pool).to receive(:enqueue).with([1, 2, 3])

      subject.enqueue(1, 2, 3)
    end
  end

  describe '#result' do
    it 'returns result from thread pool' do
      expect(thread_pool).to receive(:finalize)

      subject.result
    end
  end
end
