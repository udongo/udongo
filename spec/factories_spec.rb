require 'rails_helper'

describe 'Factories' do
  FactoryGirl.factories.map(&:name).each do |factory_name|
    it "#{factory_name} is valid" do
      expect(build(factory_name).save!).to be true
    end
  end
end
