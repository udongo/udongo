require 'rails_helper'

describe Udongo::Configs::InputLimits do
  subject { described_class.new }

  describe 'defaults' do
    it :seo_title do
      expect(subject.seo_title).to eq 40
    end

    it :seo_description do
      expect(subject.seo_description).to eq 75
    end
  end
end
