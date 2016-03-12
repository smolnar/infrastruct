require 'spec_helper'

RSpec.describe Infrastruct::Runner do
  subject { Infrastruct::Runner.new(factory) }

  let(:factory) { double(:factory, new: worker) }
  let(:worker) { double(:worker) }

  describe '#perform' do
    it 'performs args and stores result' do
      expect(worker).to receive(:perform).with(1, 2, 3)

      subject.perform([1, 2, 3])
    end
  end

  describe '#collect' do
    it 'collects results' do
      allow(worker).to receive(:perform).with(1).and_return(2)
      allow(worker).to receive(:perform).with(2).and_return(3)
      expect(worker).to receive(:collect).with([2, 3])

      subject.perform(1)
      subject.perform(2)

      subject.collect
    end
  end
end
