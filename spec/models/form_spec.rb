require 'rails_helper'

describe Form do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }

  it '#respond_to?' do
    expect(build(klass)).to respond_to(:fields)
  end
end
