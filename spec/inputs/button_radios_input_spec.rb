describe ButtonRadiosInput do
  let(:object) { double(:object) }
  let(:builder) { double(:builder, object: object, radio_button: '<input type="radio">'.html_safe) }
  subject { described_class.new(builder, 'foo', 'bar', 'blub') }

  before(:each) do
    allow(subject).to receive(:template) { ActionView::Base.new }
  end

  describe '#label_data_target' do
    it 'defaults to object name/attribute name/value' do
      allow(subject).to receive(:object_name) { :form }
      allow(subject).to receive(:attribute_name) { :field }
      expect(subject.label_data_target(:value)).to eq 'form-field-value'
    end

    it 'replaces underscores with dashes' do
      allow(subject).to receive(:object_name) { :long_object_name }
      allow(subject).to receive(:attribute_name) { :field }
      expect(subject.label_data_target(:value)).to eq 'long-object-name-field-value'
    end
  end

  describe '#collection_item_active?' do
    before do
      allow(subject).to receive(:attribute_name) { :field_name }
    end

    it 'returns true when the given value equals the value of object#{attribute_name}' do
      allow(subject).to receive(:object) { double(:object, field_name: 'foo') }
      expect(subject.collection_item_active?(:foo)).to be true
    end

    it 'returns false when the given value does not equal the value of object#{attribute_name}' do
      allow(subject).to receive(:object) { double(:object, field_name: 'bar') }
      expect(subject.collection_item_active?(:foo)).to be false
    end
  end

  describe '#label_html_options_for_collection_item' do
    it 'merges the previously set values with the ones we need for button radios' do
      allow(subject).to receive(:object_name) { :product }
      allow(subject).to receive(:attribute_name) { :field_name }
      allow(subject).to receive(:object) { double(:object, field_name: 'bar') }

      expected = {
        class: 'btn btn-primary ',
        data: { target: 'product-field-name-foo' }
      }
      expect(subject.label_html_options_for_collection_item('foo')).to eq(expected)
    end

    it 'renders the .active class when the collection item in question is active' do
      allow(subject).to receive(:object_name) { :product }
      allow(subject).to receive(:attribute_name) { :field_name }
      allow(subject).to receive(:object) { double(:object, field_name: 'bar') }

      expected = {
        class: 'btn btn-primary active',
        data: { target: 'product-field-name-bar' }
      }
      expect(subject.label_html_options_for_collection_item('bar')).to eq(expected)
    end
  end

  it '#label_text_for_collection_item' do
    allow(subject).to receive(:object_name) { :product }
    allow_any_instance_of(ActionView::Base).to receive(:t).with('simple_form.labels.product.foobar') { 'Big Foobar' }
    expect(subject.label_text_for_collection_item('foobar')).to eq 'Big Foobar'
  end

  describe '#collection_item_input_element' do
    before do
      allow(subject).to receive(:object_name) { :product }
      allow(subject).to receive(:attribute_name) { :field_name }
      allow(subject).to receive(:object) { double(:object, field_name: 'bar') }
      allow_any_instance_of(ActionView::Base).to receive(:t).with('simple_form.labels.product.foobar') { 'Big Foobar' }
    end

    it 'returns expected HTML' do
      expected = '<label class="btn btn-primary " data-target="product-field-name-foobar"><input type="radio">Big Foobar</label>'
      expect(subject.collection_item_input_element('foobar')).to eq expected
    end

    it 'returns an HTML safe string' do
      expect(subject.collection_item_input_element('foobar')).to be_instance_of(ActiveSupport::SafeBuffer)
    end
  end

  it '#responds_to?' do
    expect(subject).to respond_to(
      :input, :input_html_options, :label_html_options, :label_target,
      :label_html_options, :label_data_target, :collection_item_active?,
      :label_text_for_collection_item
    )
  end
end
