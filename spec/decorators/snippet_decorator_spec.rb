require 'rails_helper'

describe SnippetDecorator do
  describe '#title' do
    it :html do
      snippet = create(:snippet, html_title: true)
      snippet.translation(I18n.locale).title = '### Foo'
      snippet.translation(I18n.locale).save

      expect(snippet.decorate.title).to eq "<h3>Foo</h3>\n"
    end

    it :no_html do
      snippet = create(:snippet)
      snippet.translation(I18n.locale).title = 'Foo'
      snippet.translation(I18n.locale).save

      expect(snippet.decorate.title).to eq 'Foo'
    end
  end

  describe '#content' do
    it :html do
      snippet = create(:snippet, html_content: true)
      snippet.translation(I18n.locale).content = '### Foo'
      snippet.translation(I18n.locale).save

      expect(snippet.decorate.content).to eq "<h3>Foo</h3>\n"
    end

    it :no_html do
      snippet = create(:snippet)
      snippet.translation(I18n.locale).content = 'Foo'
      snippet.translation(I18n.locale).save

      expect(snippet.decorate.content).to eq 'Foo'
    end
  end

  it '#respond_to?' do
    expect(create(:snippet).decorate).to respond_to(:title, :content)
  end
end
