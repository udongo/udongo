require 'rails_helper'

describe FormSubmission do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }

  describe 'validations' do
    describe 'presence' do
      it(:form) { expect(build(klass, form: nil)).not_to be_valid }
    end
  end

  it '#respond_to?' do
    expect(build(klass)).to respond_to(:form, :data, :fields)
  end
end
