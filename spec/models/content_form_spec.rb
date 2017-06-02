require 'rails_helper'

describe ContentForm do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }

  it_behaves_like :content_type

  it '#content_type' do
    expect(build(klass).content_type).to eq :form
  end

  it '#respond_to?' do
    expect(build(klass)).to respond_to(:form, :content_type)
  end
end

