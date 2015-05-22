require 'rails_helper'

# TODO this ought to be a support spec
describe Backend::PolymorphicHelper do
  let(:model) { create(:article) }
  let(:klass) { described_class }
  let(:helper) { klass.new(type: model.class.name, id: model.id) }

  describe '#filtered' do
    it(:true) do
      expect(helper.filtered?).to be true
    end

    it(:false) do
      helper = klass.new
      expect(helper.filtered?).to be false
    end
  end

  it '#model' do
    expect(helper.model).to eq model
  end

  describe '#model_description' do
    it :translation do
      t = model.translation(Udongo::Config.default_locale)
      t.title = 'Test'
      t.save

      expect(helper.model_description).to eq 'Test'
    end

    it :model do
      allow(model).to receive(:title) { 'Test' }
      allow(model).to receive(:respond_to?).with(:translation) { false }
      allow(helper).to receive(:model) { model }
      expect(helper.model_description).to eq 'Test'
    end
  end

  describe '#type_exists' do
    it :true do
      expect(helper.type_exists?).to be true
    end

    it :false do
      helper = klass.new(type: 'Blubber', id: model.id)
      expect(helper.type_exists?).to be false
    end
  end

  it '#model_path' do
    expect(helper.model_path).to eq "/backend/articles/#{model.id}/edit"
  end

  it '#filtered_url' do
    result = "/backend/articles?commentable_id=#{model.id}&commentable_type=#{model.class.name}"
    expect(helper.filtered_url(:commentable)).to eq result
  end

  it '#respond_to?' do
    expect(klass.new).to respond_to(
      :filtered?, :model, :model_description, :model_path, :model_translation,
      :type_exists?, :filtered_url
    )
  end
end
