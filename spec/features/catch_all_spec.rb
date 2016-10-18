require 'rails_helper'

describe 'catch all for non existing routes' do
  it 'no such redirect' do
    visit '/foo/bar/baz'
    expect(page).to have_current_path('/foo/bar/baz')
    expect(page.body).to eq 'Page not found'
    expect(page.status_code).to eq 404
  end

  it 'redirect exists' do
    create(:redirect, source_uri: '/foo', destination_uri: '/bar', status_code: 301)

    visit '/foo'
    expect(page).to have_current_path('/bar')
    expect(Redirect.first.times_used).to eq 1
  end

  describe 'different formats' do
    it :html do
      visit '/foo.html'
      expect(page.body).to eq 'Page not found'
      expect(page).to have_current_path('/foo.html')
    end

    it :css do
      visit '/foo.css'
      expect(page.body).to eq 'Page not found'
      expect(page).to have_current_path('/foo.css')
    end

    it :js do
      visit '/foo.js'
      expect(page.body).to eq 'Page not found'
      expect(page).to have_current_path('/foo.js')
    end

    it :jpg do
      visit '/foo.jpg'
      expect(page.body).to eq 'Page not found'
      expect(page).to have_current_path('/foo.jpg')
    end

    it :png do
      visit '/foo.png'
      expect(page.body).to eq 'Page not found'
      expect(page).to have_current_path('/foo.png')
    end

    it :pdf do
      visit '/foo.pdf'
      expect(page.body).to eq 'Page not found'
      expect(page).to have_current_path('/foo.pdf')
    end

    it :xml do
      visit '/foo.xml'
      expect(page.body).to eq 'Page not found'
      expect(page).to have_current_path('/foo.xml')
    end
  end
end
