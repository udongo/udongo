require 'rails_helper'

describe ContentTextDecorator do
  it '#render' do
    text = build(:content_text, content: 'Foo')
    expect(text.decorate.render).to eq 'Foo'
  end

  describe '#content_type_is?' do
    it :true do
      expect(build(:content_text).decorate).to be_content_type_is(:text)
      expect(build(:content_text).decorate).to be_content_type_is('text')
    end

    it :false do
      expect(build(:content_text).decorate).not_to be_content_type_is(:image)
    end
  end

  it '#respond_to?' do
    expect(build(:content_text).decorate).to respond_to(:render, :content_type_is?)
  end
end
