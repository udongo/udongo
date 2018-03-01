require 'rails_helper'

describe Udongo::Configs::Tags do
  subject { described_class.new }

  describe 'defaults' do
    it :allow_new do
      expect(described_class.new.allow_new).to eq true
    end
  end

  describe '#allow_new?' do
    it :false do
      subject.allow_new = false
      expect(subject).not_to be_allow_new
    end

    it :true do
      subject.allow_new = true
      expect(subject).to be_allow_new
    end
  end

  it :editor_for_summary do
    expect(described_class.new.editor_for_summary).to eq false
  end
end
