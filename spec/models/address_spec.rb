require 'rails_helper'

describe Address do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }

  describe 'validations' do
    it(:addressable_id) { expect(build(klass, addressable_id: nil)).not_to be_valid }
    it(:addressable_type) { expect(build(klass, addressable_type: nil)).not_to be_valid }
  end

  it '#respond_to?' do
    expect(model.new).to respond_to(:addressable)
  end
end

