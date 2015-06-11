require 'rails_helper'

describe Udongo::Markdown do
  it '.to_html' do
    expect(Udongo::Markdown.to_html('foo bar')).to eq "<p>foo bar</p>\n"
  end

  it '.respond_to?' do
    expect(Udongo::Markdown).to respond_to(:to_html)
  end
end
