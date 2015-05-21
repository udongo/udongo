require 'rails_helper'

describe NavigationList do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }

  describe 'validations' do
    describe 'presence' do
      it(:identifier) { expect(build(klass, identifier: nil)).to_not be_valid }
      it(:description) { expect(build(klass, description: nil)).to_not be_valid }
    end
  end

  it '#responds_to?' do
    expect(build(klass)).to respond_to(:items)
  end
end
