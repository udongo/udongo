require 'rails_helper'

describe User do
  let(:klass) { described_class.to_s.underscore.to_sym }

  it_behaves_like :person

  describe 'validations' do
    describe 'presence' do
      it(:first_name) { expect(build(klass, first_name: nil)).not_to be_valid }
      it(:last_name) { expect(build(klass, last_name: nil)).not_to be_valid }
      it(:email) { expect(build(klass, email: nil)).not_to be_valid }
    end

    describe 'uniqueness' do
      it :email do
        create(klass, email: 'foo@bar.baz')
        expect(build(klass, email: 'FOO@BAR.baz')).not_to be_valid
      end
    end

    describe 'format' do
      it :email do
        expect(build(klass, email: 'foo')).not_to be_valid
        expect(build(klass, email: 'foo@bar.baz')).to be_valid
      end
    end
  end
end
