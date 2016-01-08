require 'rails_helper'

describe Concerns::Storable::Collection do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }

  before(:each) do
    @config = Concerns::Storable::Config.new
  end

  describe '#read' do
    describe 'array' do
      it 'defaults to nil' do
        @config.add :locales, :array
        collection = model.new(::Page.new, @config)
        expect(collection.locales).to eq nil
      end

      it 'defaults to provided default' do
        @config.add :locales, :array, []
        collection = model.new(::Page.new, @config)
        expect(collection.locales).to eq []
      end

      describe 'read from db' do
        it 'db contains array' do
          page = create(:page)
          create(:store, storable_type: 'Page', storable_id: page.id, klass: 'array', name: 'locales', value: [:nl])
          @config.add :locales, :array
          collection = model.new(page, @config)

          expect(collection.locales).to eq [:nl]
        end

        it 'db contains something else' do
          page = create(:page)
          create(:store, storable_type: 'Page', storable_id: page.id, klass: 'array', name: 'locales', value: 1337)
          @config.add :locales, :array
          collection = model.new(page, @config)

          expect(collection.locales).to eq nil
        end
      end
    end

    describe 'boolean' do
      it 'defaults to nil' do
        @config.add :active, :boolean
        collection = model.new(::Page.new, @config)
        expect(collection.active).to eq nil
      end

      it 'defaults to provided default' do
        @config.add :active, :boolean, true
        collection = model.new(::Page.new, @config)
        expect(collection.active).to eq true
      end

      describe 'read from db' do
        it 'db contains boolean' do
          page = create(:page)
          create(:store, storable_type: 'Page', storable_id: page.id, klass: 'boolean', name: 'active', value: true)
          @config.add :active, :boolean
          collection = model.new(page, @config)

          expect(collection.active).to eq true
        end

        it 'db contains something else' do
          page = create(:page)
          create(:store, storable_type: 'Page', storable_id: page.id, klass: 'boolean', name: 'active', value: 1337)
          @config.add :active, :boolean
          collection = model.new(page, @config)

          expect(collection.active).to eq nil
        end
      end
    end

    describe 'date' do
    end

    describe 'date_time' do
    end

    describe 'float' do
    end

    describe 'integer' do
    end

    describe 'string' do
      it 'defaults to nil' do
        @config.add :foo, :string
        collection = model.new(::Page.new, @config)
        expect(collection.foo).to eq nil
      end

      it 'defaults to provided default' do
        @config.add :foo, :string, 'bar'
        collection = model.new(::Page.new, @config)
        expect(collection.foo).to eq 'bar'
      end

      describe 'read from db' do
        it 'db contains string' do
          page = create(:page)
          create(:store, storable_type: 'Page', storable_id: page.id, klass: 'string', name: 'foo', value: 'baz')
          @config.add :foo, :string
          collection = model.new(page, @config)

          expect(collection.foo).to eq 'baz'
        end

        it 'db contains something else' do
          page = create(:page)
          create(:store, storable_type: 'Page', storable_id: page.id, klass: 'string', name: 'foo', value: 1337)
          @config.add :foo, :string
          collection = model.new(page, @config)

          expect(collection.foo).to eq nil
        end
      end
    end
  end

  # describe '#read / #write / #save' do
  #   it 'read from unknown field' do
  #     collection = model.new(::Page.new, @config)
  #     expect { collection.foo }.to raise_error(NoMethodError)
  #   end
  #
  #   it 'write to unknown field' do
  #     collection = model.new(::Page.new, @config)
  #     expect { collection.foo = 'bar' }.to raise_error(NoMethodError)
  #   end
  #
  #   it 'defaults to nil' do
  #     @config.add :foo, :string
  #     collection = model.new(::Page.new, @config)
  #
  #     expect(collection.foo).to eq nil
  #   end
  #
  #   it 'defaults to provided default' do
  #     @config.add :foo, :string, 'bar'
  #     collection = model.new(::Page.new, @config)
  #
  #     expect(collection.foo).to eq 'bar'
  #   end
  #
  # end

  # before(:each) do
  #   config = Concerns::Translatable::Config.new
  #   config.add(:title)
  #   config.add(:subtitle)
  #
  #   @collection = model.new(
  #     ::Page.new, config, :nl
  #   )
  # end
  #
  # describe '#read' do
  #   it 'cannot read when not in config' do
  #     expect { @collection.foo_bar_baz }.to raise_error(NoMethodError)
  #   end
  #
  #   it 'reads if translation is new' do
  #     expect(@collection.title).not_to be_present
  #   end
  #
  #   it 'reads if translation exists' do
  #     @collection.title = 'foo'
  #     expect(@collection.title).to eq 'foo'
  #   end
  # end
  #
  # describe '#write' do
  #   it 'cannot write fields in the config' do
  #     expect { @collection.foo_bar == 'baz' }.to raise_error(NoMethodError)
  #   end
  #
  #   it 'writes if translation is new' do
  #     @collection.title = 'foo'
  #     expect(@collection.title).to eq 'foo'
  #   end
  #
  #   it 'writes if translation exists' do
  #     Translation.create!(
  #       translatable_type: 'Page',
  #       translatable_id: 1,
  #       locale: 'nl',
  #       name: 'title',
  #       value: 'foo'
  #     )
  #
  #     @collection.title = 'bar'
  #     expect(@collection.title).to eq 'bar'
  #   end
  # end
  #
  # it '#save' do
  #   @collection.title = 'foo'
  #   @collection.subtitle = 'bar'
  #   @collection.save
  #
  #   config = Concerns::Translatable::Config.new
  #   config.add(:title)
  #   config.add(:subtitle)
  #
  #   new_collection = Concerns::Translatable::Collection.new(::Page.new, config, :nl)
  #   expect(new_collection.title).to eq 'foo'
  #   expect(new_collection.subtitle).to eq 'bar'
  # end

  it '#respond_to?' do
    collection = model.new(::Page.new, @config)
    expect(collection).to respond_to(:save, :read, :write)
  end
end
