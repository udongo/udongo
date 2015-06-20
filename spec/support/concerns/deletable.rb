require 'rails_helper'

shared_examples_for :deletable do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }

  describe 'after_intialize' do
    context 'new record' do
      it :true do
        expect(build(klass).deletable).to be true
      end

      it :false do
        expect(build(klass, deletable: false)).to be false
      end
    end

    context 'existing record after create' do
      it :false do
        instance = create(klass, deletable: false)
        expect(instance.deletable).to be false
      end
    end

    context 'existing record after save' do
      it :false do
        instance = create(klass)
        instance.update_attribute :deletable, false
        expect(instance.deletable).to be false
      end
    end
  end
end
