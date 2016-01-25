require 'rails_helper'

describe FormSubmission do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }

  describe 'validations' do
    describe 'presence' do
      it(:form) { expect(build(klass, form: nil)).not_to be_valid }
    end
  end

  describe 'data_as_hash' do
    it 'default' do
      expect(build(klass).data_as_hash).to eq({})
    end

    it 'results' do
      submission = create(klass)
      submission.data.create!(name: 'foo', value: 'bar')
      submission.data.create!(name: 'baz', value: 'bak')
      expect(submission.data_as_hash).to eq({ foo: 'bar', baz: 'bak' })
    end
  end

  it '#respond_to?' do
    expect(build(klass)).to respond_to(:form, :data, :data_as_hash)
  end
end
