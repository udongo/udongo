require 'rails_helper'
require_relative '../pages/login_page'
require_relative '../pages/snippet_page'

describe 'create snippets' do
  let(:login_page) { Features::Pages::LoginPage.new }
  let(:snippet_page) { Features::Pages::SnippetPage.new }

  before(:each) do
    login_page.visit
    login_page.login
  end

  it 'with success' do
    visit '/backend/snippets/new'
    snippet_page.fill_in_general('foo', 'bar')
    snippet_page.submit

    snippet = Snippet.first
    expect(snippet.identifier).to eq 'foo'
    expect(snippet.description).to eq 'bar'

    expect(page).to have_current_path("/backend/snippets/#{snippet.id}/edit/nl")
    expect(page).to have_content('Snippet werd toegevoegd.')
  end

  it 'without success' do
    visit '/backend/snippets/new'
    snippet_page.submit

    expect(page).to have_current_path('/backend/snippets')
    expect(page).to have_content('Er trad een fout op.')
  end
end
