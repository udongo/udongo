require 'rails_helper'

describe Form do
  let(:klass) { described_class.to_s.underscore.to_sym }

  describe 'validations' do
    describe 'presence' do
      it(:description) { expect(build(klass, description: nil)).to_not be_valid }
    end
  end

  describe '#deletable?' do
    it :true do
      expect(create(klass)).to be_deletable
    end

    it :false do
      form = create(klass)
      create(:content_form, form: form)
      expect(form).not_to be_deletable
    end
  end

  it 'translatable' do
    expect(described_class.translatable_fields_list).to eq [:redirect_url, :toggle, :success_message]
  end

  it '#respond_to?' do
    expect(build(klass)).to respond_to(:fields, :submissions, :data, :content_forms)
  end
end
