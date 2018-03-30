require 'rails_helper'

describe Udongo::Assets::Loader do
  let(:instance) { described_class.new }
  before(:each) { instance.view = ActionView::Base.new }

  describe '#files' do
    it :default do
      expect(instance.files).to eq []
    end

    it :filled do
      instance.add 'frontend/test.js'
      expect(instance.files).to eq ['frontend/test']
    end
  end

  describe 'add' do
    it(:simple) { expect(instance.add('frontend/test')).to eq ['frontend/test'] }
    it(:js) { expect(instance.add('frontend/test.js')).to eq ['frontend/test'] }
    it(:css) { expect(instance.add('frontend/test.css')).to eq ['frontend/test'] }
  end

  describe '#exists?' do
    before(:each) { instance.add 'frontend/test.js' }

    it(:true) { expect(instance.exists?('frontend/test')).to be true }
    it(:false) { expect(instance.exists?('frontend/foo')).to be false }
  end

  describe '#load_file' do
    it :true do
      expect(instance.load_file('frontend/test', :javascripts)).to be false
    end

    it :false do
      expect(instance.load_file('frontend/test', :javascripts) { true }).to be true
    end
  end

  describe '#load_css' do
    before(:each) { instance.view.controller = ActionController::Base.new }

    it :default do
      expect(instance.view.content_for?(:stylesheets)).to be false
    end

    it 'loads content' do
      instance.load_css('frontend/test', skip_pipeline: true)
      expect(instance.view.content_for?(:stylesheets)).to be true
    end
  end

  describe '#load_js' do
    before(:each) { instance.view.controller = ActionController::Base.new }

    it :default do
      expect(instance.view.content_for?(:blubber)).to be false
    end

    it 'loads content' do
      instance.load_js('frontend/test', target: :blubber, skip_pipeline: true)
      expect(instance.view.content_for?(:blubber)).to be true
    end
  end

  it '#responds_to?' do
    expect(described_class.new).to respond_to(
      :files, :view, :view=, :add, :exists?, :load_file
    )
  end
end
