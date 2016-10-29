require 'rails_helper'

describe Admin do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }

  it_behaves_like :person

  describe 'validations' do
    describe 'presence' do
      it(:locale) { expect(build(klass, locale: nil)).not_to be_valid }
      it(:first_name) { expect(build(klass, first_name: nil)).not_to be_valid }
      it(:last_name) { expect(build(klass, last_name: nil)).not_to be_valid }
    end

    describe 'email' do
      it(:value) { expect(build(klass, email: nil)).not_to be_valid }

      it :valid do
        expect(build(klass, email: 'foo')).not_to be_valid
        expect(build(klass, email: 'foo@bar.baz')).to be_valid
      end

      it :unique do
        create(klass, email: 'foo@bar.baz')
        expect(build(klass, email: 'FOO@BAR.baz')).not_to be_valid
      end
    end
  end
end
