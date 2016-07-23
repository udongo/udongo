require 'rails_helper'

describe Udongo::WillPaginate::Options do
  let(:instance) { described_class.new }

  describe '#defaults' do
    it 'class' do
      expect(instance.defaults[:class]).to eq 'pagination'
    end

    it 'inner_window' do
      expect(instance.defaults[:inner_window]).to eq 1
    end

    it 'outer_window' do
      expect(instance.defaults[:outer_window]).to eq 0
    end

    it 'renderer' do
      expect(instance.defaults[:renderer]).to eq Udongo::WillPaginate::Renderer
    end
  end

  it '#next_label' do
    allow(I18n).to receive(:t).with('will_paginate.next_label') { 'Volgende' }
    expect(instance.next_label).to eq '<span aria-hidden="true">&rarr;</span><span class="sr-only">Volgende</span>'
  end

  it '#previous_label' do
    allow(I18n).to receive(:t).with('will_paginate.previous_label') { 'Vorige' }
    expect(instance.previous_label).to eq '<span aria-hidden="true">&larr;</span><span class="sr-only">Vorige</span>'
  end

  it '#values' do
    instance = described_class.new(outer_window: 2)
    expect(instance.values[:outer_window]).to eq 2
  end

  it '#responds_to?' do
    expect(instance).to respond_to(
      :defaults, :nav_label, :next_label, :previous_label, :values
    )
  end
end
