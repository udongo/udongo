require 'rails_helper'

shared_examples_for :draggable do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }

  describe 'after_intialize' do
    context 'new record' do
      it :true do
        expect(build(klass)).to be_draggable
      end
    end

    context 'existing record after create' do
      it :false do
        instance = create(klass, draggable: false)
        expect(instance).not_to be_draggable
      end
    end

    context 'existing record after save' do
      it :false do
        instance = create(klass)
        instance.update_attribute :draggable, false
        expect(instance).not_to be_draggable
      end
    end
  end
end
