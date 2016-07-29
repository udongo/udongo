require 'rails_helper'

describe Backend::PageTranslationForm do
  let(:klass) { described_class }

  # it '#save' do
  #   page = create(:page)
  #
  #   expect(klass.new(page, page.translation(:nl)).save(
  #     title: 'bar',
  #     content: 'foo'
  #   )).to eq true
  #
  #   translation = Page.first.translation(:nl)
  #   expect(translation.title).to eq 'bar'
  #   expect(translation.content).to eq 'foo'
  # end
  #
  # it '#persisted?' do
  #   page = create(:page)
  #   expect(klass.new(page, page.translation)).to be_persisted
  # end
  #
  # it '#respond_to' do
  #   page = create(:page)
  #   instance = klass.new(page, page.translation)
  #   expect(instance).to respond_to(:save, :persisted?, :page, :translation)
  # end
end
