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
  let(:model) { create(:email_template) }
  let(:instance) { klass.new(model, model.translation) }

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
    model = create(:email_template)

    expect(klass.new(model, model.translation(:nl)).save(
      subject: 'foo',
      plain_content: 'bar',
      html_content: 'baz'
    )).to eq true

    translation = EmailTemplate.first.translation(:nl)
    expect(translation.subject).to eq 'foo'
    expect(translation.plain_content).to eq 'bar'
    expect(translation.html_content).to eq 'baz'
  end

  it '.respond_to?' do
    expect(klass).to respond_to(:model_name)
  end
end
