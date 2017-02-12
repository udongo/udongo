require 'rails_helper'

shared_examples_for :publishable do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }
  let(:instance) { build(klass) }

  describe 'scopes' do
    before(:each) do
      @a = create(klass, published_at: 3.days.from_now)
      @b = create(klass, published_at: 1.day.ago)
      @c = create(klass, published_at: 3.days.ago)
    end

    it(:published) { expect(model.published).to eq [@b, @c] }
    it(:not_published) { expect(model.not_published).to eq [@a] }
  end

  describe 'defaults' do
    it(:published_at) { expect(instance).not_to be_published }
  end

  it '#publish!' do
    instance.publish!
    expect(instance).to be_published
  end

  it '#unpublish!' do
    instance.published_at = Time.zone.now
    instance.unpublish!
    expect(instance).not_to be_unpublished
  end

  it '.respond_to?' do
    expect(model).to respond_to(:published, :not_published)
  end

  it '#respond_to?' do
    expect(model.new).to respond_to(:publish!, :unpublish!, :published?)
  end
end
