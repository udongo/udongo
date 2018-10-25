require 'rails_helper'

describe Redirect do
  let(:klass) { described_class.to_s.underscore.to_sym }

  describe 'validations' do
    describe 'presence' do
      it(:source_uri) { expect(build(klass, source_uri: nil)).not_to be_valid }
      it(:destination_uri) { expect(build(klass, destination_uri: nil)).not_to be_valid }
      it(:status_code) { expect(build(klass, status_code: nil)).not_to be_valid }
    end

    describe 'uniqueness' do
      it :source_uri do
        create(klass, source_uri: 'foo')
        expect(build(klass, source_uri: 'FOo')).not_to be_valid
      end
    end

    describe 'formatting' do
      describe '#source_uri' do
        it 'strips leading/trailing whitespace' do
          expect(create(klass, source_uri: '  foo      ').source_uri).to eq '/foo'
        end

        context 'when handling leading/trailing slashes' do
          it 'adds a leading slash when missing' do
            expect(create(klass, source_uri: 'foo').source_uri).to eq '/foo'
          end

          it 'does not add a leading slash when it already has one' do
            expect(create(klass, source_uri: '/foo').source_uri).to eq '/foo'
          end

          it 'strips basic trailing slashes' do
            expect(create(klass, source_uri: 'foo/').source_uri).to eq '/foo'
          end

          it 'strips trailing slashes in conjunction with GET params and a trailing ?' do
            expect(create(klass, source_uri: 'foo/?foo=bar').source_uri).to eq '/foo?foo=bar'
          end

          it 'strips trailing slashes in conjunction with a trailing #' do
            expect(create(klass, source_uri: 'foo/#search-results').source_uri).to eq '/foo#search-results'
          end
        end
      end
    end
  end

  describe '#enabled?' do
    it(:true) { expect(build(klass, disabled: false)).to be_enabled }
    it(:false) { expect(build(klass, disabled: true)).not_to be_enabled }
  end

  it '#used!' do
    redirect = build(klass)
    redirect.used!

    expect(redirect.times_used).to eq 1
  end

  describe 'scopes' do
    describe '.enabled' do
      it :default do
        expect(described_class.enabled).to eq []
      end

      it :result do
        redirect = create(klass, disabled: false)
        expect(described_class.enabled).to eq [redirect]
      end
    end

    describe '.disabled' do
      it :default do
        expect(described_class.disabled).to eq []
      end

      it :result do
        redirect = create(klass, disabled: true)
        expect(described_class.disabled).to eq [redirect]
      end
    end

    describe '.broken' do
      it :default do
        expect(described_class.broken).to eq []
      end

      it :result do
        redirect = create(klass, working: false)
        expect(described_class.broken).to eq [redirect]
      end
    end

    describe '.working' do
      it :default do
        expect(described_class.working).to eq []
      end

      it :result do
        redirect = create(klass, working: true)
        expect(described_class.working).to eq [redirect]
      end
    end
  end

  describe '#resolves?' do
    it 'returns false when the curl response does not indicate a redirect' do
      subject = create(:redirect, source_uri: '/nl/foo', destination_uri: '/nl/bar')

      allow_any_instance_of(Udongo::Redirects::Test).to receive(:perform!) do
        raw_response = double(:response,
                              status: '200 OK',
                              header_str: "Location: http://udongo.test/nl/foo\r\n\r\n"
                             )
        Udongo::Redirects::Response.new(raw_response)
      end

      expect(subject.resolves?(base_url: 'http://udongo.test')).to be false
    end

    it 'returns true when the curl response indicates our redirect succeeded' do
      subject = create(:redirect, source_uri: '/nl/foo', destination_uri: '/nl/bar')

      allow_any_instance_of(Udongo::Redirects::Test).to receive(:perform!) do
        raw_response = double(:response,
                              status: '200 OK',
                              header_str: "Location: http://udongo.test/nl/bar\r\n\r\n"
                             )
        Udongo::Redirects::Response.new(raw_response)
      end

      expect(subject.resolves?(base_url: 'http://udongo.test')).to be true
    end

    it 'filters out items after the hash (because Curb#last_effective_url does not return them)' do
      subject = create(:redirect, source_uri: '/nl/bar', destination_uri: '/nl/bak#foo-bar-baz')

      allow_any_instance_of(Udongo::Redirects::Test).to receive(:perform!) do
        raw_response = double(:response,
                              status: '200 OK',
                              header_str: "Location: http://udongo.test/nl/bak\r\n\r\n"
                             )
        Udongo::Redirects::Response.new(raw_response)
      end

      expect(subject.resolves?(base_url: 'http://udongo.test')).to be true
    end
  end

  describe '#next_in_chain' do
    it 'returns nil when no redirect was found with the source of the current destination' do

      expect(subject.next_in_chain).to eq nil
    end

    it 'returns a redirect record when one was found with the source of the current destination' do
      subject.destination_uri = '/nl/bar'
      redirect = create(:redirect, source_uri: subject.destination_uri)
      expect(subject.next_in_chain).to eq redirect
    end
  end

  it '#working!' do
    subject = create(klass, working: false)
    subject.working!
    expect(subject.working?).to be true
  end

  it '#broken!' do
    subject = create(klass, working: true)
    subject.broken!
    expect(subject.broken?).to be true
  end
end
