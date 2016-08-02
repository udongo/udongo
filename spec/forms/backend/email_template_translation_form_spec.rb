require 'rails_helper'

describe Backend::EmailTemplateTranslationForm do
  let(:klass) { described_class }
  let(:valid_params) do
    {
      subject: 'foo',
      plain_content: 'bar',
      html_content: 'baz'
    }
  end
  let(:email_template) { create(:email_template) }
  let(:instance) { klass.new(email_template, email_template.translation) }

  describe 'validations' do
    describe 'presence' do
      it :subject do
        params = valid_params.merge(subject: nil)
        expect(instance.save(params)).to eq false
      end

      it :plain_content do
        params = valid_params.merge(plain_content: nil)
        expect(instance.save(params)).to eq false
      end

      it :html_content do
        params = valid_params.merge(html_content: nil)
        expect(instance.save(params)).to eq false
      end
    end
  end

  it '#save' do
    email_template = create(:email_template)

    expect(klass.new(email_template, email_template.translation(:nl)).save(
      subject: 'foo',
      plain_content: 'bar',
      html_content: 'baz'
    )).to eq true

    translation = EmailTemplate.first.translation(:nl)
    expect(translation.subject).to eq 'foo'
    expect(translation.plain_content).to eq 'bar'
    expect(translation.html_content).to eq 'baz'
  end

  it '#persisted?' do
    expect(instance).to be_persisted
  end

  it '#respond_to' do
    expect(instance).to respond_to(:save, :persisted?, :email_template, :translation)
  end
end
