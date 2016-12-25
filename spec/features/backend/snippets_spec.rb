require 'rails_helper'
require_relative 'pages/login_page'
require_relative 'pages/snippet_page'

describe 'admins' do
  let(:login_page) { Features::Pages::LoginPage.new }
  let(:snippet_page) { Features::Pages::SnippetPage.new }

  before(:each) do
    login_page.visit
    login_page.login
  end

  describe 'create' do
    it 'with success' do
      visit '/backend/snippets/new'

      page.fill_in 'Interne naam', with: 'foo'
      page.fill_in 'Beschrijving', with: 'bar'
      snippet_page.submit

      expect(page).to have_current_path("/backend/snippets/#{Snippet.first.id}/edit/nl")
      expect(page).to have_content('Snippet werd toegevoegd.')
    end

    it 'without success' do
      visit '/backend/snippets/new'
      snippet_page.submit

      expect(page).to have_current_path('/backend/snippets')
      expect(page).to have_content('Er trad een fout op.')
    end
  end

  describe 'edit' do
    before(:each) do
      @snippet = create(:snippet, identifier: 'foo', description: 'bar')

      @snippet.translation(:nl).title = 'Snippet title'
      @snippet.translation(:nl).content = 'Snippet content'
      @snippet.save
    end

    describe 'general' do
      it 'with success' do
        snippet_page.visit
        page.find('tbody td:last a:first').click

        expect(page).to have_current_path("/backend/snippets/#{@snippet.id}/edit")
        expect(find_field('Interne naam').value).to eq 'foo'
        expect(find_field('Beschrijving').value).to eq 'bar'

        page.fill_in 'Interne naam', with: 'foo 2'
        page.fill_in 'Beschrijving', with: 'bar 2'
        snippet_page.submit

        expect(page).to have_current_path("/backend/snippets/#{@snippet.id}/edit")
        expect(page).to have_content('Snippet werd gewijzigd.')
        expect(find_field('Interne naam').value).to eq 'foo 2'
        expect(find_field('Beschrijving').value).to eq 'bar 2'
      end

      it 'without success' do
        snippet_page.visit
        page.find('tbody td:last a:first').click

        expect(page).to have_current_path("/backend/snippets/#{@snippet.id}/edit")
        expect(find_field('Interne naam').value).to eq 'foo'
        expect(find_field('Beschrijving').value).to eq 'bar'

        page.fill_in 'Interne naam', with: ''
        page.fill_in 'Beschrijving', with: ''
        snippet_page.submit

        expect(page).to have_current_path("/backend/snippets/#{@snippet.id}")
        expect(page).to have_content('Er trad een fout op')
        expect(find_field('Interne naam').value).to eq ''
        expect(find_field('Beschrijving').value).to eq ''
      end
    end

    describe 'translation' do
      it 'with success' do
        snippet_page.visit
        page.find('tbody td:last a:first').click
        page.click_link 'NL'

        expect(page).to have_current_path("/backend/snippets/#{@snippet.id}/edit/nl")
        expect(find_field('Titel').value).to eq 'Snippet title'
        expect(find_field('Inhoud').value).to eq 'Snippet content'

        page.fill_in 'Titel', with: 'Snippet title 2'
        page.fill_in 'Inhoud', with: 'Snippet content 2'
        page.click_button 'Opslaan'

        expect(page).to have_current_path("/backend/snippets/#{@snippet.id}/edit/nl")
        expect(find_field('Titel').value).to eq 'Snippet title 2'
        expect(find_field('Inhoud').value).to eq 'Snippet content 2'
      end

      it 'without success' do
        # Because a snippet translation form has no validations, this example
        # contains no actual expectations.
      end
    end
  end
end
