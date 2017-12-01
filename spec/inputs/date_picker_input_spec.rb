describe DatePickerInput do
  subject { described_class.new(OpenStruct.new, 'foo', 'foo', 'text') }

  before(:each) do
    allow(subject).to receive(:template) { ActionView::Base.new }
  end

  it '#data_attributes' do
    allow(I18n).to receive(:locale) { :nl }
    expect(subject.data_attributes).to eq({
      date_language: :nl,
      date_format: 'dd/mm/yyyy'
    })
  end

  it '#icon_table' do
    expect(subject.icon_table).to eq '<span class="fa fa-th"></span>'
  end

  it '#responds_to?' do
    expect(subject).to respond_to(
      :input, :data_attributes, :icon_table, :input_html_options, :span_table
    )
  end
end
