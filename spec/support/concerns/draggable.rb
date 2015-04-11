require 'rails_helper'

shared_examples_for :draggable do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }

  describe 'after_intialize' do
    context 'new record' do
      it :true do
        expect(build(klass).draggable).to be true
        pending
      end
    end

    context 'existing record after create' do
      it :false do
        instance = create(klass, draggable: false)
        expect(instance.draggable).to be false
        pending
      end
    end

    context 'existing record after save' do
      it :false do
        instance = create klass
        instance.update_attribute :draggable, false
        expect(instance.draggable).to be false
        pending
      end
    end
  end
end
