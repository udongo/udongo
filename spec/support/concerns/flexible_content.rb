require 'rails_helper'

shared_examples_for :flexible_content do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }

  it '.flexible_content?' do
    expect(model.new).to be_flexible_content
  end

  it '#respond_to?' do
    expect(model.new).to respond_to(
      :content_rows, :flexible_content?
    )
  end
end
