require 'rails_helper'

describe Backend::SnippetTranslationForm do
  let(:klass) { described_class }

  it '#save' do
    snippet = create(:snippet)

    expect(klass.new(snippet, snippet.translation(:nl)).save(
      title: 'bar',
      content: 'foo'
    )).to eq true

    translation = Snippet.first.translation(:nl)
    expect(translation.title).to eq 'bar'
    expect(translation.content).to eq 'foo'
  end

  it '#persisted?' do
    snippet = create(:snippet)
    expect(klass.new(snippet, snippet.translation)).to be_persisted
  end

  it '.respond_to?' do
    expect(klass).to respond_to(:model_name)
  end
end
