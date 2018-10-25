describe Udongo::Redirects::Response do
  describe '#success?' do
    it 'returns true when response result equals "200 OK"' do
      expect(described_class.new(double(:response, status: '200 OK')).success?).to be true
    end

    it 'returns true when response result equals "301 Moved Permanently"' do
      expect(described_class.new(double(:response, status: '301 Moved Permanently')).success?).to be true
    end

    it 'returns false when response result does not equal "200 OK"' do
      expect(described_class.new(double(:response, status: '404 Not Found')).success?).to be false
    end
  end

  describe '#endpoint_matches?' do
    it 'returns true when the sanitized destination string matches the endpoint' do
      response = double(:response, header_str: "Location: http://udongo.test/nl/foo\r\n\r\n")
      expect(described_class.new(response).endpoint_matches?('http://udongo.test/nl/foo')).to be true
    end

    it 'returns false when the sanitized destination string does not match the endpoint' do
      response = double(:response, header_str: "Location: http://udongo.test/nl/foo\r\n\r\n")
      expect(described_class.new(response).endpoint_matches?('http://udongo.test/nl/bar')).to be false
    end
  end

  describe '#sanitize_description' do
    subject { described_class.new(double(:response)) }

    it 'drops anything coming after a hash' do
      expect(subject.sanitize_destination('http://udongo.test/nl/foo?bar=123&baz=456#search-results')).to eq 'http://udongo.test/nl/foo?bar=123&baz=456'
    end

    context 'when containing a trailing slash' do
      it 'handles a trailing slash' do
        expect(subject.sanitize_destination('http://udongo.test/nl/foo/')).to eq 'http://udongo.test/nl/foo'
      end

      it 'can handle GET params' do
        expect(subject.sanitize_destination('http://udongo.test/nl/foo/?bar')).to eq 'http://udongo.test/nl/foo?bar'
      end
    end
  end
end
