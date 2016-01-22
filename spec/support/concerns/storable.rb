require 'rails_helper'

shared_examples_for :storable do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }

  it '#storable?' do
    expect(build(klass)).to be_storable
  end

  it '#respond_to?' do
    expect(build(klass)).to respond_to(:store, :storable?)
  end

  it '.respond_to?' do
    expect(model).to respond_to(:storable_field, :store_config)
  end
end
