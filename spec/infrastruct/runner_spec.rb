require 'spec_helper'

RSpec.describe Infrastruct::Runner do
  subject { Infrastruct::Runner.new(factory) }

  let(:factory) { double(:factory, new: worker) }
  let(:worker) { double(:worker) }

  describe '#perform' do
    it 'performs args' do
      expect(worker).to receive(:perform).with(1, 2, 3)

      subject.perform([1, 2, 3])
    end
  end

  describe '#collect' do
    it 'collects results' do
      expect(worker).to receive(:collect).with([1, 2, 3, 4, 5])

      subject.collect([1, 2, 3, 4, 5])
    end
  end
end
