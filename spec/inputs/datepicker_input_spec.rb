require 'rails_helper'

describe DatepickerInput do
  let(:instance) { described_class.new(OpenStruct.new, 'foo', 'foo', 'text') }
  before(:each) do
    allow(instance).to receive(:template) { ActionView::Base.new }
  end

  it '#data_attributes' do
    allow(I18n).to receive(:locale) { :nl }
    expect(instance.data_attributes).to eq({ date_language: :nl, date_format: 'dd/mm/yyyy' })
  end

  it '#icon_table' do
    expect(instance.icon_table).to eq '<span class="fa fa-th"></span>'
  end

  it '#responds_to?' do
    expect(instance).to respond_to(
      :input, :data_attributes, :icon_table, :input_html_options, :span_table
    )
  end
end
