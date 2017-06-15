require 'rails_helper'

describe ContentTextDecorator do
  it '#render' do
    text = build(:content_text, content: 'Foo')
    expect(text.decorate.render).to eq 'Foo'
  end

  it '#respond_to?' do
    expect(build(:content_text).decorate).to respond_to(:render)
  end
end
