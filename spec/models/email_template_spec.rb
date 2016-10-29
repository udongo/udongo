require 'rails_helper'

describe EmailTemplate do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }

  it_behaves_like :translatable
  it_behaves_like :sortable

  describe 'validations' do
    describe 'presence' do
      it(:identifier) { expect(build(klass, identifier: nil)).not_to be_valid }
      it(:description) { expect(build(klass, description: nil)).not_to be_valid }
      it(:from_name) { expect(build(klass, from_name: nil)).not_to be_valid }
    end

    describe 'identifier' do
      it :unique do
        create(klass, identifier: 'foo')
        expect(build(klass, identifier: 'FOO')).not_to be_valid
      end
    end

    describe 'from_email' do
      it(:value) { expect(build(klass, from_email: nil)).not_to be_valid }

      it :valid do
        expect(build(klass, from_email: 'foo')).not_to be_valid
        expect(build(klass, from_email: 'foo@bar.baz')).to be_valid
      end
    end

    describe 'cc' do
      it(:blank) { expect(build(klass, cc: nil)).to be_valid }

      it :valid do
        expect(build(klass, cc: 'foo')).not_to be_valid
        expect(build(klass, cc: 'foo@bar.baz')).to be_valid
      end
    end

    describe 'bcc' do
      it(:blank) { expect(build(klass, bcc: nil)).to be_valid }

      it :valid do
        expect(build(klass, bcc: 'foo')).not_to be_valid
        expect(build(klass, bcc: 'foo@bar.baz')).to be_valid
      end
    end
  end

  it 'translatable' do
    expect(model.translatable_fields_list).to eq [:subject, :plain_content, :html_content]
  end
end
