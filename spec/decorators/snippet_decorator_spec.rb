require 'rails_helper'

describe SnippetDecorator do
  describe '#title' do
    it 'nil will always return a string' do
      snippet = create(:snippet)
      expect(snippet.decorate.title).to eq ''
      expect(snippet.decorate.title).to be_a(String)
    end

    it :html do
      snippet = create(:snippet, allow_html_in_title: true)
      snippet.translation(I18n.locale).title = 'foo<br>bar'
      snippet.translation(I18n.locale).save

      expect(snippet.decorate.title).to eq 'foo<br>bar'
      expect(snippet.decorate.title).to be_a(ActiveSupport::SafeBuffer)
    end

    it :no_html do
      snippet = create(:snippet)
      snippet.translation(I18n.locale).title = 'Foo'
      snippet.translation(I18n.locale).save

      expect(snippet.decorate.title).to eq 'Foo'
      expect(snippet.decorate.title).to be_a(String)
    end
  end

  describe '#content' do
    it 'nil will always return a string' do
      snippet = create(:snippet)
      expect(snippet.decorate.content).to eq ''
      expect(snippet.decorate.content).to be_a(String)
    end

    it :html do
      snippet = create(:snippet, allow_html_in_content: true)
      snippet.translation(I18n.locale).content = 'foo<br>bar'
      snippet.translation(I18n.locale).save

      expect(snippet.decorate.content).to eq 'foo<br>bar'
      expect(snippet.decorate.content).to be_a(ActiveSupport::SafeBuffer)
    end

    it :no_html do
      snippet = create(:snippet)
      snippet.translation(I18n.locale).content = 'Foo'
      snippet.translation(I18n.locale).save

      expect(snippet.decorate.content).to eq 'Foo'
      expect(snippet.decorate.content).to be_a(String)
    end
  end

  it '#respond_to?' do
    expect(create(:snippet).decorate).to respond_to(:title, :content)
  end
end
