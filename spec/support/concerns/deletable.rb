require 'rails_helper'

shared_examples_for :deletable do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }

  describe 'after_intialize' do
    context 'new record' do
      it :true do
        expect(build(klass)).to be_deletable
      end

      it :false do
        expect(build(klass, deletable: false)).not_to be_deletable
      end
    end

    context 'existing record after create' do
      it :false do
        instance = create(klass, deletable: false)
        expect(instance).not_to be_deletable
      end
    end

    context 'existing record after save' do
      it :false do
        instance = create(klass)
        instance.update_attribute :deletable, false
        expect(instance).not_to be_deletable
      end
    end
  end
end
