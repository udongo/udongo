require 'rails_helper'

describe Concerns::Storable::Collection do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }

  before(:each) do
    @config = Concerns::Storable::Config.new
  end

  describe '#read' do
    it 'no such field configurated' do
      collection = model.new(::Page.new, @config)
      expect { collection.foo }.to raise_error(NoMethodError)
    end

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
      it 'defaults to nil' do
        @config.add :starts_on, :date
        collection = model.new(::Page.new, @config)
        expect(collection.starts_on).to eq nil
      end

      it 'defaults to provided default' do
        @config.add :starts_on, :date, Date.today
        collection = model.new(::Page.new, @config)
        expect(collection.starts_on).to eq Date.today
      end

      describe 'read from db' do
        it 'db contains date' do
          page = create(:page)
          create(:store, storable_type: 'Page', storable_id: page.id, klass: 'date', name: 'starts_on', value: Date.today)
          @config.add :starts_on, :date
          collection = model.new(page, @config)

          expect(collection.starts_on).to eq Date.today
        end

        it 'db contains something else' do
          page = create(:page)
          create(:store, storable_type: 'Page', storable_id: page.id, klass: 'date', name: 'starts_on', value: 1337)
          @config.add :starts_on, :date
          collection = model.new(page, @config)

          expect(collection.starts_on).to eq nil
        end
      end
    end

    describe 'date_time' do
      it 'defaults to nil' do
        @config.add :last_login_at, :date
        collection = model.new(::Page.new, @config)
        expect(collection.last_login_at).to eq nil
      end

      it 'defaults to provided default' do
        now = DateTime.now
        @config.add :last_login_at, :date, now
        collection = model.new(::Page.new, @config)
        expect(collection.last_login_at).to eq now
      end

      describe 'read from db' do
        it 'db contains date_time' do
          now = DateTime.now
          page = create(:page)
          create(:store, storable_type: 'Page', storable_id: page.id, klass: 'date_time', name: 'last_login_at', value: now)
          @config.add :last_login_at, :date_time
          collection = model.new(page, @config)

          expect(collection.last_login_at).to eq now
        end

        it 'db contains something else' do
          page = create(:page)
          create(:store, storable_type: 'Page', storable_id: page.id, klass: 'date_time', name: 'last_login_at', value: 1337)
          @config.add :last_login_at, :date_time
          collection = model.new(page, @config)

          expect(collection.last_login_at).to eq nil
        end
      end
    end

    describe 'float' do
      it 'defaults to nil' do
        @config.add :discount, :float
        collection = model.new(::Page.new, @config)
        expect(collection.discount).to eq nil
      end

      it 'defaults to provided default' do
        @config.add :discount, :float, 1.1
        collection = model.new(::Page.new, @config)
        expect(collection.discount).to eq 1.1
      end

      describe 'read from db' do
        it 'db contains float' do
          page = create(:page)
          create(:store, storable_type: 'Page', storable_id: page.id, klass: 'float', name: 'discount', value: 1.0)
          @config.add :discount, :float
          collection = model.new(page, @config)

          expect(collection.discount).to eq 1.0
        end

        it 'db contains something else' do
          page = create(:page)
          create(:store, storable_type: 'Page', storable_id: page.id, klass: 'float', name: 'discount', value: 1337)
          @config.add :discount, :float
          collection = model.new(page, @config)

          expect(collection.discount).to eq nil
        end
      end
    end

    describe 'integer' do
      it 'defaults to nil' do
        @config.add :age, :integer
        collection = model.new(::Page.new, @config)
        expect(collection.age).to eq nil
      end

      it 'defaults to provided default' do
        @config.add :age, :integer, 101
        collection = model.new(::Page.new, @config)
        expect(collection.age).to eq 101
      end

      describe 'read from db' do
        it 'db contains integer' do
          page = create(:page)
          create(:store, storable_type: 'Page', storable_id: page.id, klass: 'integer', name: 'age', value: 101)
          @config.add :age, :integer
          collection = model.new(page, @config)

          expect(collection.age).to eq 101
        end

        it 'db contains something else' do
          page = create(:page)
          create(:store, storable_type: 'Page', storable_id: page.id, klass: 'integer', name: 'age', value: true)
          @config.add :age, :integer
          collection = model.new(page, @config)

          expect(collection.age).to eq nil
        end
      end
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

  describe '#write' do
    it 'no such field configurated' do
      collection = model.new(::Page.new, @config)
      expect { collection.foo = 'bar' }.to raise_error(NoMethodError)
    end

    describe 'array' do
      before(:each) do
        @config.add :foo, :array, []
        @collection = model.new(::Page.new, @config)
      end

      it 'an actual array' do
        @collection.foo = [1, 2, 3]
        expect(@collection.foo).to eq [1, 2, 3]
      end

      it 'something else' do
        @collection.foo = { foo: 'bar' }
        expect(@collection.foo).to eq []
      end

      it '<<' do
        @collection.foo << :bar
        expect(@collection.foo).to eq [:bar]
        @collection.save

        expect(::Store.first.value).to eq [:bar]
      end
    end

    describe 'boolean' do
      before(:each) do
        @config.add :foo, :boolean
        @collection = model.new(::Page.new, @config)
      end

      it 'true' do
        @collection.foo = true
        expect(@collection.foo).to eq true
      end

      it 'false' do
        @collection.foo = false
        expect(@collection.foo).to eq false
      end

      it '1 => true' do
        @collection.foo = 1
        expect(@collection.foo).to eq true
      end

      it '"1" => true' do
        @collection.foo = '1'
        expect(@collection.foo).to eq true
      end

      it '0 => false' do
        @collection.foo = 0
        expect(@collection.foo).to eq false
      end

      it '"0" => false' do
        @collection.foo = '0'
        expect(@collection.foo).to eq false
      end

      it 'something else' do
        @collection.foo = 'foo'
        expect(@collection.foo).to eq nil
      end
    end

    describe 'date' do
      before(:each)  do
        @config.add :foo, :date
        @collection = model.new(::Page.new, @config)
      end

      it 'an actual date' do
        @collection.foo = Date.today
        expect(@collection.foo).to eq Date.today
      end

      it 'date as a string' do
        @collection.foo = '2016-01-07'
        expect(@collection.foo).to eq Date.parse('2016-01-07')
      end

      it 'incorrect date as string' do
        @collection.foo = '2016-99-99'
        expect(@collection.foo).to eq nil
      end

      it 'something else' do
        @collection.foo = 'foo'
        expect(@collection.foo).to eq nil
      end
    end

    describe 'date_time' do
      before(:each)  do
        @config.add :foo, :date_time
        @collection = model.new(::Page.new, @config)
      end

      it 'an actual datetime' do
        now = DateTime.now
        @collection.foo = now
        expect(@collection.foo).to eq now
      end

      it 'datetime as a string' do
        @collection.foo = '2016-01-07 14:45:33'
        expect(@collection.foo).to eq DateTime.parse('2016-01-07 14:45:33')
      end

      it 'incorrect datetime as a string' do
        @collection.foo = '2016-01-07 99:99:99'
        expect(@collection.foo).to eq nil
      end

      it 'something else' do
        @collection.foo = 'foo'
        expect(@collection.foo).to eq nil
      end
    end

    describe 'float' do
      before(:each) do
        @config.add :foo, :float
        @collection = model.new(::Page.new, @config)
      end

      it 'an actual float' do
        @collection.foo = 13.37
        expect(@collection.foo).to eq 13.37
      end

      it 'something else' do
        @collection.foo = 1337
        expect(@collection.foo).to eq nil
      end
    end

    describe 'integer' do
      before(:each) do
        @config.add :foo, :integer
        @collection = model.new(::Page.new, @config)
      end

      it 'an actual integer' do
        @collection.foo = 1337
        expect(@collection.foo).to eq 1337
      end

      it 'something else' do
        @collection.foo = '1337'
        expect(@collection.foo).to eq nil
      end
    end

    describe 'string' do
      before(:each) do
        @config.add :foo, :string, ''
        @collection = model.new(::Page.new, @config)
      end

      it 'an actual string' do
        @collection.foo = 'bar'
        expect(@collection.foo).to eq 'bar'
      end

      it 'a symbol' do
        @collection.foo = :bar
        expect(@collection.foo).to eq 'bar'
      end

      it 'something else' do
        @collection.foo = 1337
        expect(@collection.foo).to eq ''
      end

      it '<<' do
        @collection.foo << 'foo'
        expect(@collection.foo).to eq 'foo'

        @collection.foo << 'bar'
        expect(@collection.foo).to eq 'foobar'

        @collection.save
        expect(::Store.first.value).to eq 'foobar'
      end
    end
  end

  it '#save' do
    page = create(:page)

    @config.add :locales, :array
    @config.add :active, :boolean
    @config.add :starts_on, :date
    @config.add :starts_at, :date_time
    @config.add :discount, :float
    @config.add :age, :integer
    @config.add :email, :string


    collection = model.new(page, @config)
    collection.locales = [:nl, :fr]
    collection.active = true
    collection.starts_on = Date.today
    collection.starts_at = DateTime.parse('2016-01-07 14:45')
    collection.discount = 13.37
    collection.age = 37
    collection.email = 'foo@bar.baz'
    collection.save

    collection = model.new(page, @config)
    expect(collection.locales).to eq [:nl, :fr]
    expect(collection.active).to eq true
    expect(collection.starts_on).to eq Date.today
    expect(collection.starts_at).to eq DateTime.parse('2016-01-07 14:45')
    expect(collection.discount).to eq 13.37
    expect(collection.age).to eq 37
    expect(collection.email).to eq 'foo@bar.baz'
  end

  it '#respond_to?' do
    collection = model.new(::Page.new, @config)
    expect(collection).to respond_to(:save, :read, :write)
  end
end
