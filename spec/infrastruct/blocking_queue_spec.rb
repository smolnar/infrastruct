require 'spec_helper'

RSpec.describe Infrastruct::BlockingQueue do
  let(:queue) { double(:queue) }

  before :each do
    allow(::Queue).to receive(:new) { queue }
  end

  describe '#push' do
    it 'pushes into queue' do
      expect(queue).to receive(:push).with(:argument)

      subject.push(:argument)
    end
  end

  describe '#pop' do
    it 'pop values' do
      expect(queue).to receive(:pop).with(false)

      subject.pop
    end

    context 'when nonblocking' do
      it 'pop values and does not block' do
        subject.unblock!

        expect(queue).to receive(:pop).with(true)

        subject.pop
      end
    end
  end
end
