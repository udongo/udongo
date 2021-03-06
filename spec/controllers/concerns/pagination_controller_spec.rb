require 'rails_helper'

class Controller < Struct.new(:index)
  include Concerns::PaginationController

  def params
    {}
  end
end

describe Concerns::PaginationController do
  let(:controller) { Controller.new }

  describe '#paginate' do
    before(:each) do
      (1..10).each { |i| create(:page, id: i) }
      allow(controller).to receive(:params) { { per_page: 5, page: 2 } }
    end

    it 'array' do
      records = Page.all.to_a
      expect(controller.paginate(records).map(&:id)).to eq [6,7,8,9,10]
    end

    it 'ActiveRecord' do
      records = Page.all
      expect(controller.paginate(records).map(&:id)).to eq [6,7,8,9,10]
    end

    describe 'options hash' do
      let(:records) { Page.all }

      it 'page' do
        expect(controller.paginate(records, page: 1).map(&:id)).to eq [1,2,3,4,5]
        expect(controller.paginate(records, page: 2).map(&:id)).to eq [6,7,8,9,10]
      end

      it 'per_page' do
        expect(controller.paginate(records, page: 1, per_page: 2).map(&:id)).to eq [1,2]
        expect(controller.paginate(records, page: 2, per_page: 3).map(&:id)).to eq [4,5,6]
      end
    end
  end

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

  describe '#per_page' do
    it 'defaults to 10' do
      allow(controller).to receive(:params) { {} }
      expect(controller.per_page).to eq 10
    end

    it '5' do
      allow(controller).to receive(:params) { { per_page: '5' }}
      expect(controller.per_page).to eq 5
    end

    it '10' do
      allow(controller).to receive(:params) { { per_page: '10' }}
      expect(controller.per_page).to eq 10
    end

    it '25' do
      allow(controller).to receive(:params) { { per_page: '25' }}
      expect(controller.per_page).to eq 25
    end

    it '30' do
      allow(controller).to receive(:params) { { per_page: '30' }}
      expect(controller.per_page).to eq 30
    end

    it '50' do
      allow(controller).to receive(:params) { { per_page: '50' }}
      expect(controller.per_page).to eq 50
    end

    it '100' do
      allow(controller).to receive(:params) { { per_page: '100' }}
      expect(controller.per_page).to eq 100
    end
  end
end
