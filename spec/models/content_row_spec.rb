require 'rails_helper'
require "#{Udongo::PATH}/spec/support/concerns/sortable"

describe ContentRow do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }

  it_behaves_like :sortable
  it_behaves_like :locale

  describe 'validations' do
    describe 'presence' do
      it(:locale) { expect(build(klass, locale: nil)).not_to be_valid }
    end
  end

  it '#respond_to?' do
    expect(build(klass)).to respond_to(:rowable, :columns)
  end
end
