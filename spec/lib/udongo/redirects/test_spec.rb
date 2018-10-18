describe Udongo::Redirects::Test do
  let(:redirect) { double(:redirect, source_uri: '/nl/foo') }
  subject { described_class.new(redirect) }

  it '#perform!' do
    expect(Curl::Easy).to receive(:perform).with('http://udongo.test/nl/foo')
    subject.perform!(base_url: 'http://udongo.test')
  end
end
