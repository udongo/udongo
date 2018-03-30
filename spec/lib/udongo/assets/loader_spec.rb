require 'rails_helper'

describe Udongo::Assets::Loader do
  before do
    subject.view = ActionView::Base.new
    allow(File).to receive(:exists?) { true }
  end

  describe '#files' do
    it :default do
      expect(subject.files).to eq []
    end

    it :filled do
      subject.add 'frontend/test.js'
      expect(subject.files).to eq ['frontend/test']
    end
  end

  describe 'add' do
    it(:simple) { expect(subject.add('frontend/test')).to eq ['frontend/test'] }
    it(:js) { expect(subject.add('frontend/test.js')).to eq ['frontend/test'] }
    it(:css) { expect(subject.add('frontend/test.css')).to eq ['frontend/test'] }
  end

  describe '#exists?' do
    before(:each) { subject.add 'frontend/test.js' }

    it(:true) { expect(subject.exists?('frontend/test')).to be true }
    it(:false) { expect(subject.exists?('frontend/foo')).to be false }
  end

  describe '#load_file' do
    it :true do
      expect(subject.load_file('frontend/test', :javascripts)).to be false
    end

    it :false do
      expect(subject.load_file('frontend/test', :javascripts) { true }).to be true
    end
  end

  xdescribe '#load_css' do
    before(:each) { subject.view.controller = ActionController::Base.new }

    it :default do
      expect(subject.view.content_for?(:stylesheets)).to be false
    end

    it 'loads content' do
      subject.load_css('frontend/test')
      expect(subject.view.content_for?(:stylesheets)).to be true
    end
  end

  xdescribe '#load_js' do
    before(:each) { subject.view.controller = ActionController::Base.new }

    it :default do
      expect(subject.view.content_for?(:blubber)).to be false
    end

    it 'loads content' do
      subject.load_js('frontend/test', :blubber)
      expect(subject.view.content_for?(:blubber)).to be true
    end
  end

  it '#responds_to?' do
    expect(described_class.new).to respond_to(
      :files, :view, :view=, :add, :exists?, :load_file
    )
  end
end
