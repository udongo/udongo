require 'rails_helper'

shared_examples_for :emailable do
  it '#respond_to?' do
    expect(described_class.new).to respond_to(:email_vars)
  end
end
