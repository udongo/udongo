require 'rails_helper'

describe Email do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }

  describe 'validations' do
    it(:from_name) { expect(build(klass, from_name: nil)).not_to be_valid }
    it(:to_name) { expect(build(klass, to_name: nil)).not_to be_valid }
    it(:subject) { expect(build(klass, subject: nil)).not_to be_valid }
    it(:plain_content) { expect(build(klass, plain_content: nil)).not_to be_valid }
    it(:html_content) { expect(build(klass, html_content: nil)).not_to be_valid }

    describe 'from_mail' do
      it(:presence) { expect(build(klass, from_email: nil)).not_to be_valid }

      it :valid do
        expect(build(klass, from_email: 'foo')).not_to be_valid
        expect(build(klass, from_email: 'foo@bar.baz')).to be_valid
      end
    end

    describe 'to_email' do
      it(:presence) { expect(build(klass, to_email: nil)).not_to be_valid }

      it :valid do
        expect(build(klass, to_email: 'foo')).not_to be_valid
        expect(build(klass, to_email: 'foo@bar.baz')).to be_valid
      end
    end
  end

  describe 'scopes' do
    before(:each) do
      @a = create(:email, sent_at: nil)
      @b = create(:email, sent_at: DateTime.now)
    end

    it '.sent' do
      expect(model.sent).to eq [@b]
    end

    it '.not_sent' do
      expect(model.not_sent).to eq [@a]
    end
  end

  it '.respond_to?' do
    expect(model).to respond_to(:sent, :not_sent)
  end
end

