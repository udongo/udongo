require 'rails_helper'

describe FormSubmission do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }

  it_behaves_like :emailable

  describe 'validations' do
    describe 'presence' do
      it(:form) { expect(build(klass, form: nil)).not_to be_valid }
    end
  end

  describe 'data_object' do
    it 'no results' do
      expect(build(klass).data_object.foo).to be nil
    end

    it 'results' do
      submission = create(klass)
      submission.data.create!(name: 'foo', value: 'bar')
      submission.data.create!(name: 'baz', value: 'bak')
      expect(submission.data_object.foo).to eq 'bar'
      expect(submission.data_object.baz).to eq 'bak'
    end
  end

  it '#respond_to?' do
    expect(build(klass)).to respond_to(:form, :data, :data_object)
  end
end
