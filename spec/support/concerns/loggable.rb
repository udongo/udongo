require 'rails_helper'

shared_examples_for :loggable do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }

  it :logs do
    a = create(klass)
    a.log 'foo', category: 'bar', data: { baz: true }
    expect(a.logs.count).to be >= 1
    expect(a.logs.unscoped.last.content).to eq 'foo'
    expect(a.logs.unscoped.last.category).to eq 'bar'
    expect(a.logs.unscoped.last.data).to eq({ baz: true })
  end

  it '#respond_to?' do
    expect(model.new).to respond_to(:logs, :log)
  end
end
