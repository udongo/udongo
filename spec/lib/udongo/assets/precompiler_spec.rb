require 'rails_helper'

describe Udongo::Assets::Precompiler do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }
  let(:instance) { model.new Rails.application }

  it '#respond_to?' do
    expect(instance).to respond_to(
      :add_images, :add_javascript, :add_stylesheets
    )
  end
end
