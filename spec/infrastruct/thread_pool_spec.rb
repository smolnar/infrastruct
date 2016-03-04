require 'spec_helper'

RSpec.describe Infrastruct::ThreadPool do
  subject { Infrastruct::ThreadPool.new(threads: 5) }

  describe '#run' do
    it 'runs thread with nonblocking queue' do
      args = (0..300).to_a
      block = -> {}

      args.each do |n|
        expect(block).to receive(:call).with(n)
      end

      args.each do |n|
        subject.enqueue(n)
      end

      subject.run(&block)
    end
  end

  describe '#enqueue' do
    it 'it enqueues params for worker' do
      subject.enqueue(1)

      expect(subject.queue.pop).to eql(1)
    end

    it 'enqueues blocks as well' do
      block = -> { }
      subject.enqueue([1, block])

      expect(subject.queue.pop).to eql([1, block])
    end
  end
end
