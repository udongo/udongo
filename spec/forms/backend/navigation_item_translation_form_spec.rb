require 'rails_helper'

describe Backend::NavigationItemTranslationForm do
  let(:klass) { described_class }

  it '#save' do
    navigation_item = create(:navigation_item)

    expect(klass.new(navigation_item, navigation_item.translation(:nl)).save(
      label: 'bar',
      path: 'foo'
    )).to eq true

    translation = NavigationItem.first.translation(:nl)
    expect(translation.label).to eq 'bar'
    expect(translation.path).to eq 'foo'
  end

  it '#persisted?' do
    navigation_item = create(:navigation_item)
    expect(klass.new(navigation_item, navigation_item.translation)).to be_persisted
  end

  it '#respond_to' do
    navigation_item = create(:navigation_item)
    instance = klass.new(navigation_item, navigation_item.translation)
    expect(instance).to respond_to(:save, :persisted?, :navigation_item, :translation)
  end
end
