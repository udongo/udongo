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

          it 'strips hash anchors' do
            expect(create(klass, source_uri: 'foo/#search-results').source_uri).to eq '/foo'
          end

          it 'strips GET params' do
            expect(create(klass, source_uri: 'nl/foo/?config=345').source_uri).to eq '/nl/foo'
          end
        end
      end

      describe '#destination_uri' do
        it 'strips leading/trailing whitespace' do
          expect(create(klass, destination_uri: '  foo      ').destination_uri).to eq '/foo'
        end

        context 'when handling leading/trailing slashes' do
          it 'adds a leading slash when missing' do
            expect(create(klass, destination_uri: 'foo').destination_uri).to eq '/foo'
          end

          it 'does not add a leading slash when it already has one' do
            expect(create(klass, destination_uri: '/foo').destination_uri).to eq '/foo'
          end

          it 'strips basic trailing slashes' do
            expect(create(klass, destination_uri: 'foo/').destination_uri).to eq '/foo'
          end

          it 'strips trailing slashes in conjunction with GET params and a trailing ?' do
            expect(create(klass, destination_uri: 'foo/?foo=bar').destination_uri).to eq '/foo?foo=bar'
          end

          it 'strips trailing slashes in conjunction with a trailing #' do
            expect(create(klass, destination_uri: 'foo/#search-results').destination_uri).to eq '/foo#search-results'
          end

          it 'does not strip GET params' do
            expect(create(klass, destination_uri: 'nl/foo/?config=345').destination_uri).to eq '/nl/foo?config=345'
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

  describe '#calculate_jumps' do
    it 'has a jumps of 0 by default' do
      expect(subject.calculate_jumps).to eq 1
    end

    it 'accounts for one additional redirect' do
      subject = create(:redirect, source_uri: '/nl/foo', destination_uri: '/nl/foo/new')
      create(:redirect, source_uri: subject.destination_uri)
      expect(subject.calculate_jumps).to eq 2
    end

    it 'accounts for two additional redirects' do
      subject = create(:redirect, source_uri: '/nl/foo', destination_uri: '/nl/foo/new')
      create(:redirect, source_uri: '/nl/foo/new', destination_uri: '/nl/bar')
      create(:redirect, source_uri: '/nl/bar', destination_uri: '/nl/bar/new')
      expect(subject.calculate_jumps).to eq 3
    end
  end

  describe '#trace_down' do
    it 'returns the passed redirect when no previous redirects were found' do
      subject = create(:redirect, source_uri: 'foo', destination_uri: 'bar')
      expect(subject.trace_down).to eq [subject]
    end

    it 'returns the stack of redirects starting with the first one when multiple redirects were found' do
      subject = create(:redirect, source_uri: 'foo', destination_uri: 'bar')
      third = create(:redirect, source_uri: 'baz', destination_uri: 'boo')
      second = create(:redirect, source_uri: 'bar', destination_uri: 'baz')
      expect(subject.trace_down).to eq [subject, second, third]
    end
  end

  describe '#trace_up' do
    it 'returns the passed redirect when no previous redirects were found' do
      subject = create(:redirect, source_uri: 'foo', destination_uri: 'bar')
      expect(subject.trace_up).to eq [subject]
    end

    it 'returns the stack of redirects starting with the first one when multiple redirects were found' do
      first = create(:redirect, source_uri: 'foo', destination_uri: 'bar')
      subject = create(:redirect, source_uri: 'bar', destination_uri: 'baz')
      expect(subject.trace_up).to eq [first, subject]
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
