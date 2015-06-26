require 'spec_helper'

describe ScopeDelegation do
  let(:association) { double }

  class ActiveRecordDouble
    extend ScopeDelegation

    def self.reflect_on_association(association)
      association
    end
  end

  it 'has a version number' do
    expect(ScopeDelegation::VERSION).not_to be nil
  end

  describe '.delegate_scope' do
    it 'calls scope' do
      expect(ActiveRecordDouble).to receive(:scope)
      ActiveRecordDouble.delegate_scope :some_scope, to: :association
    end
  end
end
