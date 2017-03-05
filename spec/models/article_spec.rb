require 'rails_helper'

describe Article do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }

  it_behaves_like :taggable
  it_behaves_like :visible
  it_behaves_like :seo
  it_behaves_like :flexible_content
  it_behaves_like :searchable
  it_behaves_like :translatable

  it 'translatable' do
    expect(model.translatable_fields_list).to eq [:title, :summary]
  end

  it 'searchable fields' do
    expect(model.searchable_fields_list).to eq [:title, :summary, :flexible_content]
  end

  it '#responds_to?' do
    expect(build(klass)).to respond_to(:user)
  end
end
