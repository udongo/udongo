require 'rails_helper'

describe Backend::SnippetForm do
  let(:klass) { described_class }
  let(:valid_params) do
    {
      identifier: 'foo',
      description: 'bar'
    }
  end
  let(:instance) { klass.new }

  describe 'validations' do
    describe 'presence' do
      it :description do
        params = valid_params.merge(description: nil)
        expect(instance.save(params)).to eq false
      end
    end

    describe 'identifier' do
      it :presence do
        params = valid_params.merge(identifier: nil)
        expect(instance.save(params)).to eq false
      end

      describe 'unique' do
        it 'create' do
          create(:snippet, valid_params)

          params = valid_params.merge(identifier: 'foo')
          expect(instance.save(params)).to eq false
        end

        it 'update' do
          snippet = create(:snippet, valid_params)

          params = valid_params.merge(identifier: 'foo')
          expect(klass.new(snippet).save(params)).to eq true
        end
      end
    end
  end

  describe '#save' do
    it 'create' do
      expect(instance.save(valid_params)).to eq true

      snippet = Snippet.first
      expect(snippet.identifier).to eq 'foo'
      expect(snippet.description).to eq 'bar'
    end

    it 'update' do
      snippet = create(:snippet, valid_params)

      expect(klass.new(snippet).save(
        identifier: 'bar',
        description: 'baz'
      )).to eq true

      snippet = Snippet.first
      expect(snippet.identifier).to eq 'bar'
      expect(snippet.description).to eq 'baz'
    end
  end

  describe '#persisted?' do
    it :true do
      snippet = create(:snippet)
      expect(klass.new(snippet)).to be_persisted
    end

    it :false do
      expect(klass.new).not_to be_persisted
    end
  end

  it '#respond_to' do
    expect(klass.new).to respond_to(:save, :persisted?, :snippet)
  end
end
