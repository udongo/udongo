require 'rails_helper'

describe 'authentication' do
  let(:admin) { create(:admin, email: 'foo@bar.baz', password: 'foo', password_confirmation: 'foo') }

  describe 'redirects to login when not logged in' do
    it 'visiting /backend' do
      get '/backend'
      expect(response).to redirect_to('/backend/sessions/new')
    end

    it 'visiting /backend/admins' do
      get '/backend/admins'
      expect(response).to redirect_to('/backend/sessions/new')
    end
  end

  describe 'login' do
    it 'directly through login page' do
      post '/backend/sessions', params: { session: { email: admin.email, password: 'foo' }}
      expect(response).to redirect_to('/backend')
    end

    it 'via admins' do
      get '/backend/admins'
      post '/backend/sessions', params: { session: { email: admin.email, password: 'foo' }}
      expect(response).to redirect_to('/backend/admins')
    end
  end

  describe 'logout' do
    it 'redirects to login of already logged out' do
      delete '/backend/sessions/37'
      expect(response).to redirect_to('/backend/sessions/new')
    end

    it 'redirects to login if actually logging out' do
      post '/backend/sessions', params: { session: { email: admin.email, password: 'foo' }}
      expect(response).to redirect_to('/backend')

      delete '/backend/sessions/37'
      expect(response).to redirect_to('/backend/sessions/new')
    end
  end

  # logout
  # -> redirects to login if already logged out
  # -> redirects to login if actually loggin out
end
