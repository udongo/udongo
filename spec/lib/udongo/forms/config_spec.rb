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
    allow(Udongo.config.forms).to receive(:foo) do
      OpenStruct.new(datagrid_fields: [:foo, :bar], filter_fields: [:foo])
    end
  end

  it '#config' do
    form = create(:form, identifier: 'foo')
    expect(instance.config.datagrid_fields).to eq([:foo, :bar])
    expect(instance.config.filter_fields).to eq([:foo])
  end

  it '#responds_to?' do
    expect(self).to respond_to(:config)
  end
end
