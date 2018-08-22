require 'rails_helper'

shared_examples_for :attachable do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }

  it '#respond_to?' do
    expect(model.new).to respond_to(:attachments)
  end
end
