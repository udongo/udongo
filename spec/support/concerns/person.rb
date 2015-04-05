require 'rails_helper'

shared_examples_for :person do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }

  it :full_name do
    person = build(klass, first_name: 'Foo', last_name: 'Bar')
    expect(person.full_name).to eq 'Foo Bar'
  end

  it '#respond_to?' do
    expect(model.new).to respond_to(:full_name)
  end
end
