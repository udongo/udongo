describe Udongo::Redirects::Response do
  describe '#ok?' do
    it 'returns true when response result equals "200 OK"' do
      expect(described_class.new(double(:response, status: '200 OK')).ok?).to be true
    end

    it 'returns false when response result does not equal "200 OK"' do
      expect(described_class.new(double(:response, status: '404 Not Found')).ok?).to be false
    end
  end

  describe '#not_found?' do
    it 'returns true when response result equals "200 OK"' do
      expect(described_class.new(double(:response, status: '404 Not Found')).not_found?).to be true
    end

    it 'returns false when response result does not equal "200 OK"' do
      expect(described_class.new(double(:response, status: '200 OK')).not_found?).to be false
    end
  end

  describe '#redirect_works?' do
    context 'when the status code equals 200 OK' do
      it 'returns true when the sanitized destination string matches the endpoint' do
        response = double(:response, last_effective_url: 'http://udongo.test/nl/foo', status: '200 OK')
        expect(described_class.new(response).redirect_works?('http://udongo.test/nl/foo')).to be true
      end

      it 'returns false when the sanitized destination string does not match the endpoint' do
        response = double(:response, last_effective_url: 'http://udongo.test/nl/foo', status: '200 OK')
        expect(described_class.new(response).redirect_works?('http://udongo.test/nl/bar')).to be false
      end
    end

    it 'returns false when the sanitized destination string matches the endpoint' do
      response = double(:response, last_effective_url: 'http://udongo.test/nl/foo', status: '404 Not Found')
      expect(described_class.new(response).redirect_works?('http://udongo.test/nl/foo')).to be false
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
