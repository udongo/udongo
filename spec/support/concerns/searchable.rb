require 'rails_helper'

shared_examples_for :searchable do
  let(:klass) { described_class.to_s.underscore.to_sym }

  it '#respond_to?' do
    expect(described_class.new).to respond_to(:search_indices)
  end
end
