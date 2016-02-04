require 'rails_helper'

describe Address do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }

  it_behaves_like :emailable

  it '#respond_to?' do
    expect(model.new).to respond_to(:addressable)
  end
end

