require 'rails_helper'

describe Udongo::Forms::SubmissionFilter do
  let(:form) { create(:form, identifier: 'foo') }
  let(:instance) { described_class.new(form) }

  describe '#result' do
    let(:other_form) { create(:form, identifier: 'contact') }
    let(:a) { create(:form_submission, form: form) }
    let(:b) { create(:form_submission, form: form) }
    let(:c) { create(:form_submission, form: form) }
    let(:d) { create(:form_submission, form: other_form) }
    let(:e) { create(:form_submission, form: other_form) }

    it 'default' do
      expect(instance.result).to eq []
    end

    context 'data present' do
      before(:each) do
        # Form 1
        create(:form_submission_data, submission: a, name: 'full_name', value: 'John Doe')
        create(:form_submission_data, submission: a, name: 'email', value: 'john@example.com')
        create(:form_submission_data, submission: b, name: 'full_name', value: 'Jane Doe-McEnroe')
        create(:form_submission_data, submission: b, name: 'email', value: 'jane@example.com')
        create(:form_submission_data, submission: c, name: 'full_name', value: 'Bill Doe')
        create(:form_submission_data, submission: c, name: 'email', value: 'bill@doe.com')

        # Form 2
        create(:form_submission_data, submission: d, name: 'full_name', value: 'James McEnroe')
        create(:form_submission_data, submission: d, name: 'email', value: 'james@example.com')
        create(:form_submission_data, submission: e, name: 'full_name', value: 'Jenny McEnroe')
        create(:form_submission_data, submission: e, name: 'email', value: 'jenny@example.com')
      end

      it 'no params given, ignore filter' do
        expect(instance.result).to eq [a, b, c]
      end

      it 'looks for data in the right form' do
        allow(instance).to receive(:params) { { full_name: 'McEnroe' } }
        expect(instance.result).to eq [b]
      end

      describe 'params given, with results' do
        it 'single param' do
          allow(instance).to receive(:params) { { full_name: 'John' } }
          expect(instance.result).to eq [a]
        end

        it 'multiple params work with OR' do
          allow(instance).to receive(:params) { { full_name: 'Jane', email: '@example.com' } }
          expect(instance.result).to eq [a,b]
        end
      end
    end
  end

  it '.responds_to?' do
    expect(described_class).to respond_to(:search)
  end

  it '#responds_to?' do
    expect(instance).to respond_to(:result, :fields)
  end
end
