require 'rails_helper'
require_relative '../../pages/login_page'

describe 'duplicate flexible content' do
  let(:login_page) { Features::Pages::LoginPage.new }
  let(:email_template_page) { Features::Pages::EmailTemplatePage.new }

  before(:each) do
    login_page.visit
    login_page.login
  end

  it 'with success' do
    article = create(:article)
    widget = create(:content_text, content: 'This is my text.')
    row = create(:content_row, rowable: article, locale: 'nl')
    create(
      :content_column,
      row: row,
      content_type: widget.class,
      content_id: widget.id
    )

    visit "/backend/articles/#{article.id}/edit/fr"
    expect(page).to have_content('Wil je de inhoud liever overnemen van een andere taal?')

    page.find('#content-rows').click_link('NL')
    expect(page).to have_current_path("/backend/articles/#{article.id}/edit/fr")
    expect(page).to have_content('De flexibele inhoud werd gedupliceerd.')
    expect(page).to have_content('This is my text.')
  end

  describe 'without success' do
    it 'no such class' do
      visit '/backend/content/duplicate/foo/1/nl/en'
      expect(page).to have_current_path('/backend')
    end

    it 'no record found for class and id combination' do
      visit '/backend/content/duplicate/article/9999999/nl/en'
      expect(page).to have_current_path('/backend')
    end

    it 'bad source locale' do
      article = create(:article)
      expect { visit("/backend/content/duplicate/article/#{article.id}/foo/en") }.to raise_error(RuntimeError, 'No valid source locale provided (foo)')
    end

    it 'bad destination locale' do
      article = create(:article)
      expect { visit("/backend/content/duplicate/article/#{article.id}/nl/foo") }.to raise_error(RuntimeError, 'No valid destination locale provided (foo)')
    end
  end
end
