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
    # TODO:
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
