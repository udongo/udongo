require 'rails_helper'

describe Udongo::Configs::Base do
  let(:klass) { described_class }

  describe 'defaults' do
    it :host do
      expect(klass.new.host).to eq 'udongo.dev'
    end

    it :project_name do
      expect(klass.new.project_name).to eq 'Udongo'
    end

    it :time_zone do
      expect(klass.new.time_zone).to eq 'Brussels'
    end
  end

  it '#respond_to?' do
    expect(klass.new).to respond_to(
      :host, :host=, :time_zone, :time_zone=, :project_name, :project_name=
    )
  end
end
