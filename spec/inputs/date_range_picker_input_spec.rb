require 'rails_helper'

describe DateRangePickerInput do
  let(:instance) { described_class.new(OpenStruct.new, 'foo', 'foo', 'text') }
  before(:each) do
    allow(instance).to receive(:template) { ActionView::Base.new }
  end

  it '#data_attributes' do
    allow(I18n).to receive(:locale) { :nl }
    expect(instance.data_attributes).to eq({
      date_language: :nl,
      date_format: 'dd/mm/yyyy',
      range_picker: false,
      start: nil,
      stop: nil
    })
  end

  describe '#range_picker?' do
    describe 'true' do
      it 'start' do
        instance = described_class.new(OpenStruct.new, 'foo', 'foo', 'foo', start: 'foo')
        expect(instance.range_picker?).to be true
      end

      it 'stop' do
        instance = described_class.new(OpenStruct.new, 'foo', 'foo', 'foo', stop: 'foo')
        expect(instance.range_picker?).to be true
      end
    end

    it 'false' do
      expect(instance.range_picker?).to be false
    end
  end

  it '#responds_to?' do
    expect(instance).to respond_to(
      :input, :data_attributes, :icon_table, :input_html_options, :span_table
    )
  end
end
