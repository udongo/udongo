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

    context 'when containing a trailing slash' do
      it 'handles a trailing slash' do
        expect(subject.sanitize_destination('http://udongo.test/nl/foo/')).to eq 'http://udongo.test/nl/foo'
      end

      it 'can handle GET params' do
        expect(subject.sanitize_destination('http://udongo.test/nl/foo/?bar=1')).to eq 'http://udongo.test/nl/foo?bar=1'
      end

      it 'can handle hashes' do
        expect(subject.sanitize_destination('http://udongo.test/nl/foo/#search-results')).to eq 'http://udongo.test/nl/foo/#search-results'
      end
    end
  end

  describe '#headers' do
    it 'can format a single Location header' do
      header_string = "HTTP/1.1 301 Moved Permanently\r\nX-XSS-Protection: 1; mode=block\r\nX-Content-Type-Options: nosniff\r\nLocation: http://reli.test/fr/provence/var/detente\r\n\r\n"
      subject = described_class.new(double(:response, header_str: header_string))
      expect(subject.headers['Location']).to eq 'http://reli.test/fr/provence/var/detente'
    end

    it 'can format multiple Location headers' do
      header_string = "HTTP/1.1 301 Moved Permanently\r\nX-XSS-Protection: 1; mode=block\r\nX-Content-Type-Options: nosniff\r\nLocation: http://reli.test/fr/provence/var/detente\r\nContent-Type: text/html; charset=utf-8\r\nCache-Control: no-cache\r\nX-Request-Id: 716daafb-d9d3-4f5d-a9d4-141663b8f48a\r\nX-Runtime: 0.050885\r\nSet-Cookie: __profilin=p%3Dt; path=/\r\nDate: Fri, 26 Oct 2018 07:57:24 GMT\r\nConnection: close\r\n\r\nHTTP/1.1 301 Moved Permanently\r\nX-XSS-Protection: 1; mode=block\r\nX-Content-Type-Options: nosniff\r\nLocation: http://reli.test/fr/provence/var/la-detente\r\n\r\n"
      subject = described_class.new(double(:response, header_str: header_string))
      expect(subject.headers['Location']).to eq 'http://reli.test/fr/provence/var/la-detente'
    end
  end
end
