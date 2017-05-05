require 'rails_helper'

describe FormField do
  let(:klass) { described_class.to_s.underscore.to_sym }

  it_behaves_like :sortable
  it_behaves_like :translatable

  describe 'validations' do
    describe 'presence' do
      it(:form) { expect(build(klass, form: nil)).to_not be_valid }
      it(:identifier) { expect(build(klass, identifier: nil)).to_not be_valid }
      it(:field_type) { expect(build(klass, field_type: nil)).to_not be_valid }
    end

    describe 'uniqueness' do
      describe 'identifier' do
        let(:form) { create(:form) }

        describe 'valid' do
          it 'scoped on form' do
            create(klass, identifier: 'blub', form: form)
            expect(build(klass, identifier: 'foo', form: form)).to be_valid
          end

          it 'not scoped on form' do
            create(klass, identifier: 'blub')
            expect(build(klass, identifier: 'blub')).to be_valid
          end
        end

        it 'invalid' do
          create(klass, identifier: 'foo', form: form)
          expect(build(klass, identifier: 'foo', form: form)).to_not be_valid
        end
      end
    end
  end

  it 'translatable' do
    expect(described_class.translatable_fields_list).to eq [:label, :default_value]
  end

  it '#respond_to?' do
    expect(build(klass)).to respond_to(:form)
  end
end
