require 'rails_helper'

shared_examples_for :searchable do
  let(:klass) { described_class.to_s.underscore.to_sym }

  describe 'after_create' do
    before(:each) do
      allow(described_class).to receive(:searchable_fields_list) { [:foo] }
    end

    context 'non-translatable model' do
      before(:each) do
        allow_any_instance_of(described_class).to receive(:translatable?) { false }
        allow_any_instance_of(described_class).to receive(:foo) { 'bar' }
      end

      it 'default' do
        instance = build(klass)
        expect(instance.search_indices).to eq []
      end

      it 'creates a search index' do
        instance = create(klass)
        expect(instance.search_indices.find_by(locale: :nl, key: 'foo').value).to eq 'bar'
      end
    end

    context 'translatable model' do
      before(:each) do
        described_class.translatable_fields :foo, :bar
      end

      let(:create_instance!) do
        instance = build(klass)
        Udongo.config.i18n.app.locales.each do |l|
          t = instance.translation(l.to_sym)
          t.foo = "baz #{l}"
          t.bar = 'bak'
        end
        instance.save
        instance
      end

      it 'creates search indices for every translation' do
        instance = create_instance!
        expect(instance.search_indices.find_by(locale: :nl, key: 'foo').value).to eq 'baz nl'
        expect(instance.search_indices.find_by(locale: :fr, key: 'foo').value).to eq 'baz fr'
        expect(instance.search_indices.find_by(locale: :en, key: 'foo').value).to eq 'baz en'
      end

      it 'does not copy translatable fields that are not in searchable fields' do
        instance = create_instance!
        expect(instance.search_indices.find_by(locale: :nl, key: 'bar')).to be nil
      end
    end
  end

  describe 'after_save' do
    context 'non-translatable model' do
      before(:each) do
        allow(described_class).to receive(:searchable_fields_list) { [:foo] }
        allow_any_instance_of(described_class).to receive(:translatable?) { false }
        allow_any_instance_of(described_class).to receive(:foo) { 'bar' }
      end

      it 'default' do
        instance = build(klass)
        expect(instance.search_indices).to eq []
      end

      it 'saves the search index' do
        allow(Udongo.config.i18n.app).to receive(:default_locale) { :nl }
        instance = create(klass)
        expect(instance.search_indices.find_by(locale: :nl, key: 'foo').value).to eq 'bar'

        # We have to make sure the model has an updated value for foo,
        # so Searchable can read it on save.
        allow_any_instance_of(described_class).to receive(:foo) { 'bak' }
        instance.save
        expect(instance.search_indices.find_by(locale: :nl, key: 'foo').value).to eq 'bak'
      end
    end

    context 'translatable model' do
      it 'updates the search index' do
        allow(described_class).to receive(:searchable_fields_list) { [:foo] }
        allow(described_class).to receive(:translatable_fields_list) { [:foo] }
        allow_any_instance_of(described_class).to receive(:translatable?) { false }
        allow_any_instance_of(described_class).to receive(:foo) { 'bar' }
        instance = create(klass)
        expect(instance.search_indices.find_by(locale: :nl, key: 'foo').value).to eq 'bar'

        # We have to make sure the model has an updated value for foo,
        # so Searchable can read it on save.
        allow_any_instance_of(described_class).to receive(:foo) { 'bak' }
        instance.save
        expect(instance.search_indices.find_by(locale: :nl, key: 'foo').value).to eq 'bak'
      end
    end
  end

  it '.respond_to?' do
    expect(described_class).to respond_to(
      :searchable_field, :searchable_fields, :searchable_fields_list
    )
  end

  it '#respond_to?' do
    expect(described_class.new).to respond_to(:search_indices)
  end
end
