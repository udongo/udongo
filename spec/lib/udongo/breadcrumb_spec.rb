require 'rails_helper'

describe Udongo::Breadcrumb do
  let(:instance) { Udongo::Breadcrumb.new }

  it '#all' do
    expect(instance.all).to eq []
  end

  it '#add' do
    instance.add :foo, :bar
    expect(instance.all).to eq [{ name: :foo, link: :bar }]
  end

  describe '#any?' do
    it :false do
      expect(instance).not_to be_any
    end

    it :true do
      instance.add :foo, :bar
      expect(instance).to be_any
    end
  end

  it '#respond_to?' do
    expect(instance).to respond_to(:all, :add, :any?, :each)
  end
end
