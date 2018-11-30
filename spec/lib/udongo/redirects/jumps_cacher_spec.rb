require 'rails_helper'

describe Udongo::Redirects::JumpsCacher do

  it '#cache!' do
    redirect = create(:redirect, source_uri: 'foo', destination_uri: 'bar')
    subject = described_class.new(redirect)
    expect(redirect).to receive(:cache_jumps!)
    subject.cache!
  end

  describe '#top_most_redirect' do
    let(:redirect) { create(:redirect, source_uri: 'foo', destination_uri: 'bar') }
    subject { described_class.new(redirect) }

    it 'returns the passed redirect when no previous redirects were found' do
      expect(subject.top_most_redirect).to eq redirect
    end

    it 'returns the redirect located at the front of the trace stack when multiple redirects were found' do
      second = create(:redirect, source_uri: 'bar', destination_uri: 'baz')
      third = create(:redirect, source_uri: 'baz', destination_uri: 'boo')
      first = create(:redirect, source_uri: 'foo', destination_uri: 'bar')
      subject = described_class.new(third)
      expect(subject.top_most_redirect).to eq first
    end
  end
end
