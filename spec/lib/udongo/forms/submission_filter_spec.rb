require 'rails_helper'

describe Udongo::Forms::SubmissionFilter do
  let(:instance) { described_class.new }

  describe '#result' do
    it 'default' do
      expect(instance.result).to eq []
    end

    it 'without filter' do
      submission = create(:form_submission)
      create(:form_submission_data, submission: submission, name: 'foo', value: 'bar')
      expect(instance.result).to eq [submission]
    end
  end

  it '.responds_to?' do
    expect(described_class).to respond_to(:search)
  end

  it '#responds_to?' do
    expect(instance).to respond_to(:result)
  end
end
