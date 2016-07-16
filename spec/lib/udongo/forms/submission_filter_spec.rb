require 'rails_helper'

describe Udongo::Forms::SubmissionFilter do
  let(:form) { create(:form) }
  let(:instance) { described_class.new(form) }

  describe '#result' do
    let(:a) { create(:form_submission) }
    let(:b) { create(:form_submission) }

    it 'default' do
      expect(instance.result).to eq []
    end

    context 'data present' do
      before(:each) do
        create(:form_submission_data, submission: a, name: 'foo', value: 'bar')
        create(:form_submission_data, submission: b, name: 'foo', value: 'baz')
      end

      it 'no params given, ignore filter' do
        expect(instance.result).to eq [a, b]
      end

      it 'params given, no results' do
        allow(instance).to receive(:params) { { foo: 'blub' } }
        expect(instance.result).to eq []
      end

      it 'params given, with result' do
        allow(instance).to receive(:params) { { foo: 'baz' } }
        expect(instance.result).to eq [b]
      end
    end
  end

  it '.responds_to?' do
    expect(described_class).to respond_to(:search)
  end

  it '#responds_to?' do
    expect(instance).to respond_to(:result, :config, :fields)
  end
end
