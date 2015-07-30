require 'rails_helper'

class Controller < Struct.new(:index)
  include Concerns::PaginationController
end

describe Concerns::PaginationController do
  let(:controller) { Controller.new }

  describe '#page_number' do
    it 'default value' do
      allow(controller).to receive(:params) { {} }
      expect(controller.page_number).to eq 1
    end

    it :string do
      allow(controller).to receive(:params) { { page: '../../../../../../etc/passwd' } }
      expect(controller.page_number).to eq 1
    end

    it :integer do
      allow(controller).to receive(:params) { { page: '20' } }
      expect(controller.page_number).to eq 20
    end

    it :array do
      allow(controller).to receive(:params) { { page: [] } }
      expect(controller.page_number).to eq 1
    end

    it :hash do
      allow(controller).to receive(:params) { { page: {} } }
      expect(controller.page_number).to eq 1
    end
  end
end
