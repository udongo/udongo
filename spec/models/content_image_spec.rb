require 'rails_helper'

describe ContentImage do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }

  it_behaves_like :content_type

  it '#content_type' do
    expect(build(klass).content_type).to eq :image
  end

  it '#respond_to?' do
    expect(build(klass)).to respond_to(:content_type)
  end
end
