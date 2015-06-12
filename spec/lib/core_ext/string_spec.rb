require 'rails_helper'

describe String do
  it '#to_html' do
    expect('foo'.to_html).to eq "<p>foo</p>\n"
  end

  it '#respond_to?' do
    expect('foo').to respond_to(:to_html)
  end
end
