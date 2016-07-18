require 'rails_helper'

class TestClass
  include Udongo::Forms::Config

  def initialize(form)
    @form = form
  end
end

describe Udongo::Forms::Config do
  let(:form) { create(:form, identifier: 'foo') }
  let(:instance) { TestClass.new(form) }

  before(:each) do
    allow(Udongo.config).to receive(:form_submissions) do
      { foo: { datagrid_fields: [:foo, :bar], filter: [:foo] } }
    end
  end

  describe '#config' do
    it 'with matching form identifier' do
      expect(instance.config).to eq({ datagrid_fields: [:foo, :bar], filter: [:foo] })
    end

    it 'without matching form identifier' do
      form.update_attribute(:identifier, 'bar')
      expect(instance.config).to be nil
    end
  end

  it '#responds_to?' do
    expect(self).to respond_to(:config)
  end
end
