require 'rails_helper'

describe Redirect do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }

  describe 'validations' do
    describe 'presence' do
      it(:source) { expect(build(klass, source: nil)).to_not be_valid }
      it(:destination) { expect(build(klass, destination: nil)).to_not be_valid }
      it(:status_code) { expect(build(klass, status_code: nil)).to_not be_valid }
    end
  end
end
