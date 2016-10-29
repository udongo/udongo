require 'rails_helper'

describe Backend::EmailTemplateForm do
  let(:klass) { described_class }
  let(:valid_params) do
    {
      identifier: 'foo',
      description: 'bar',
      from_name: 'baz',
      from_email: 'foo@bar.baz'
    }
  end
  let(:instance) { klass.new(EmailTemplate.new) }

  describe 'validations' do
    describe 'presence' do
      it :description do
        params = valid_params.merge(description: nil)
        expect(instance.save(params)).to eq false
      end

      it :from_name do
        params = valid_params.merge(from_name: nil)
        expect(instance.save(params)).to eq false
      end
    end

    describe 'identifier' do
      it :presence do
        params = valid_params.merge(identifier: nil)
        expect(instance.save(params)).to eq false
      end

      describe 'unique' do
        it 'create' do
          create(:email_template, valid_params)

          params = valid_params.merge(identifier: 'foo')
          expect(instance.save(params)).to eq false
        end

        it 'update' do
          email_template = create(:email_template, valid_params)

          params = valid_params.merge(identifier: 'foo')
          expect(klass.new(email_template).save(params)).to eq true
        end
      end
    end

    describe 'from_email' do
      it :presence do
        params = valid_params.merge(from_email: nil)
        expect(instance.save(params)).to eq false
      end

      it :valid do
        params = valid_params.merge(from_email: 'foo')
        expect(instance.save(params)).to eq false

        params = valid_params.merge(from_email: 'foo@bar.baz')
        expect(instance.save(params)).to eq true
      end
    end

    describe 'cc' do
      it :blank do
        params = valid_params.merge(cc: nil)
        expect(instance.save(params)).to eq true
      end

      it :valid do
        params = valid_params.merge(cc: 'foo')
        expect(instance.save(params)).to eq false

        params = valid_params.merge(cc: 'foo@bar.baz')
        expect(instance.save(params)).to eq true
      end
    end

    describe 'bcc' do
      it :blank do
        params = valid_params.merge(bcc: nil)
        expect(instance.save(params)).to eq true
      end

      it :valid do
        params = valid_params.merge(bcc: 'foo')
        expect(instance.save(params)).to eq false

        params = valid_params.merge(bcc: 'foo@bar.baz')
        expect(instance.save(params)).to eq true
      end
    end
  end

  describe '#save' do
    it 'create' do
      expect(instance.save(valid_params)).to eq true

      email_template = EmailTemplate.first
      expect(email_template.identifier).to eq 'foo'
      expect(email_template.description).to eq 'bar'
      expect(email_template.from_name).to eq 'baz'
      expect(email_template.from_email).to eq 'foo@bar.baz'
    end

    it 'update' do
      email_template = create(:email_template, valid_params)

      expect(klass.new(email_template).save(
        identifier: 'bar',
        description: 'baz',
        from_name: 'Patrick',
        from_email: 'patrick@swayze.com'
      )).to eq true

      email_template = EmailTemplate.first
      expect(email_template.identifier).to eq 'bar'
      expect(email_template.description).to eq 'baz'
      expect(email_template.from_name).to eq 'Patrick'
      expect(email_template.from_email).to eq 'patrick@swayze.com'
    end
  end

  describe '#persisted?' do
    it :true do
      email_template = create(:email_template)
      expect(klass.new(email_template)).to be_persisted
    end

    it :false do
      expect(klass.new(EmailTemplate.new)).not_to be_persisted
    end
  end

  it '#respond_to' do
    expect(klass.new(EmailTemplate.new)).to respond_to(:save, :persisted?, :email_template)
  end
end
