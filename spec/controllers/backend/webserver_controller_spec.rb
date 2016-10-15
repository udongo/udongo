require 'rails_helper'

describe Backend::WebserverController do
  before(:each) do
    @admin = create(:admin)
    session[:admin_id] = @admin.id
  end

  describe 'POST restart' do
    it 'touches tmp/restart.txt' do
      post :restart
      expect(File.exists?('tmp/restart.txt')).to eq true
    end

    it 'redirects to /backend' do
      post :restart
      expect(response).to redirect_to('/backend')
      expect(flash[:notice]).to eq 'De webserver werd opnieuw opgestart'
    end
  end
end
