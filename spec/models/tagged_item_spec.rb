require 'rails_helper'

describe TaggedItem do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }

  describe 'validations' do
    describe 'presence' do
      it(:tag) { expect(build(klass, tag: nil)).not_to be_valid }
    end
  end

  describe :after_destroy do
    let(:tag) { create(:tag, locale: 'nl', name: 'foo', slug: 'foo') }

    before(:each) do
      @item1 = create(:tagged_item, taggable_id: 1, tag_id: tag.id)
      @item2 = create(:tagged_item, taggable_id: 2, tag_id: tag.id)
    end

    context 'tags in use' do
      it :true do
        @item2.destroy

        expect(Tag.exists?(id: tag.id)).to be true
      end

      it :false do
        @item1.destroy
        @item2.destroy

        expect(Tag.exists?(id: tag.id)).to be false
      end
    end
  end

  it '#respond_to?' do
    expect(model.new).to respond_to(:taggable)
  end
end

