require 'rails_helper'

shared_examples_for :sortable do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }

  describe 'scopes' do
    it :default_scope do
      a = create(klass, position: 2)
      b = create(klass, position: 3)
      c = create(klass, position: 1)
      expect(model.all).to eq [c, a, b]
    end

    it 'new records' do
      a = create(klass)
      b = create(klass)
      c = create(klass)
      expect(model.all).to eq [a, b, c]
    end
  end

  describe '#set_position' do
    before :each do
      @first = create klass, position: 1

      if @first.scope_condition.is_a?(Hash)
        @second = create klass, @first.scope_condition.merge!({ position: 2 })
      else
        @second = create klass, position: 2
      end
    end

    it :parentable do
      if @first.respond_to?(:parentable) && @first.parentable? && @first.scope_name == 'parent_id'
        two = create(klass, parent_id: @first.id)
        three = create(klass)

        three.set_position 2, @first.id
        expect(three.parent_id).to eq @first.id
      end
    end

    context 'draggable' do
      it :with do
        if @first.respond_to?(:draggable)
          @first.update_attribute :draggable, false
          @first.set_position 2

          expect(model.find(@first.id).position).to eq 1
          expect(model.find(@second.id).position).to eq 2
        end
      end

      # You can't test the state without draggable/parentable reliably, due
      # to scope issues.
    end
  end

  it '.respond_to?' do
    expect(model).to respond_to(:acts_as_list, :sortable)
  end

  it '#respond_to?' do
    expect(model.new).to respond_to(:set_position, :set_list_position)
  end
end
