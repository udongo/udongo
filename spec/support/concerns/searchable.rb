require 'rails_helper'

shared_examples_for :searchable do
  let(:klass) { described_class.to_s.underscore.to_sym }

  describe 'after_save' do
    context 'non-translatable model' do
      before(:each) do
        # Because this is a spec/support included through it_behaves_like,
        # we have to mock the entry points of the data used in
        # Concerns::Searchable.
        allow(described_class).to receive(:searchable_fields_list) { [:foo] }
        allow(described_class).to receive(:translatable_fields_list) { [] }
        allow_any_instance_of(described_class).to receive(:foo) { 'bar' }
      end

      it 'default' do
        instance = build(klass)
        expect(instance.search_indices).to eq []
      end

      it 'creates a search index' do
        instance = create(klass)
        expect(instance.search_indices.find_by(locale: :nl, name: 'foo').value).to eq 'bar'
      end

      it 'saves an existing search index' do
        instance = create(klass)
        allow(instance).to receive(:foo) { 'foobar' }
        instance.save!
        expect(instance.search_indices.find_by(locale: :nl, name: 'foo').value).to eq 'foobar'
      end
    end

    if described_class.respond_to?(:translatable_fields)
      before(:each) do
        allow(described_class).to receive(:searchable_fields_list) { [:foo] }
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
          expect(instance.search_indices.find_by(locale: :nl, name: 'foo').value).to eq 'baz nl'
          expect(instance.search_indices.find_by(locale: :fr, name: 'foo').value).to eq 'baz fr'
          expect(instance.search_indices.find_by(locale: :en, name: 'foo').value).to eq 'baz en'
        end

        it 'saves existing search indices for every translation' do
          instance = create_instance!

          Udongo.config.i18n.app.locales.each do |l|
            t = instance.translation(l.to_sym)
            t.foo = "foobar #{l}"
            t.bar = 'barfoo'
          end

          instance.save

          expect(instance.search_indices.find_by(locale: :nl, name: 'foo').value).to eq 'foobar nl'
          expect(instance.search_indices.find_by(locale: :fr, name: 'foo').value).to eq 'foobar fr'
          expect(instance.search_indices.find_by(locale: :en, name: 'foo').value).to eq 'foobar en'
        end

        it 'does not copy translatable fields that are not in searchable fields' do
          instance = create_instance!
          expect(instance.search_indices.find_by(locale: :nl, name: 'bar')).to be nil
        end
      end
    end

    if described_class.respond_to?(:content_rows)
      context 'model with flexible_content' do
        let(:instance) { create(klass) }
        let(:content) { create(:content_text, content: 'Lorem ipsum') }

        before(:each) do
          # Because this is a spec/support included through it_behaves_like,
          # we have to mock the entry points of the data used in
          # Concerns::Searchable.
          allow(described_class).to receive(:searchable_fields_list) { [:foo] }
          allow_any_instance_of(described_class).to receive(:foo) { 'bar' }
          allow_any_instance_of(Concerns::Storable::Collection).to receive(:foo) { 'bar' }

          row = create(:content_row, locale: 'nl', rowable: instance)
          row.columns << create(:content_column, content: content)
          instance.content_rows << row
        end

        it 'saves index when updating searchable instance' do
          instance.save!
          key = "flexible_content:#{content.id}"
          expect(instance.search_indices.find_by(locale: :nl, name: key).value).to eq 'Lorem ipsum'
        end

        it 'saves index when updating flexible content' do
          instance.save!
          content.content = 'Dolor sit amet'
          content.save!
          key = "flexible_content:#{content.id}"
          expect(instance.search_indices.find_by(locale: :nl, name: key).value).to eq 'Dolor sit amet'
        end
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
