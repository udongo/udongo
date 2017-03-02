require 'rails_helper'

shared_examples_for :imageable do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }
  let(:instance) { create(klass) }

  it '#imageable?' do
    expect(instance).to be_imageable
  end

  it '#respond_to?' do
    expect(model.new).to respond_to(:images, :imageable?)
  end
end
