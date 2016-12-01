require 'rails_helper'

describe UserDecorator do
  let(:user) { create(:user) }
  let(:instance) { user.decorate }
  it('decorated?') { expect(instance).to be_decorated_with described_class }

  describe '#abbreviation' do
    before(:each) do
      instance.user.first_name = nil
      instance.user.last_name = nil
      instance.user.display_name = nil
    end

    it 'display_name' do
      instance.user.display_name = 'Pretzl'
      expect(instance.abbreviation).to eq 'P'
    end

    it 'first+last name' do
      instance.user.first_name = 'Dave'
      instance.user.last_name = 'Lens'
      expect(instance.abbreviation).to eq 'DL'
    end

    it 'falls back to full e-mail' do
      instance.user.email = 'john.doe@example.com'
      expect(instance.abbreviation).to eq 'john.doe@example.com'
    end
  end

  it '#responds_to?' do
    expect(instance).to respond_to(
      :abbreviation
    )
  end
end
