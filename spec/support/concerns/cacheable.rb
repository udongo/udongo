require 'rails_helper'

shared_examples_for :cacheable do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }

  it '.respond_to?' do
    expect(model).to respond_to(:find_in_cache)
  end
end
