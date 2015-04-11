require 'rails_helper'

describe Note do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }

  describe 'validations' do
    describe 'presence' do
      it(:content) { expect(build(klass, content: nil)).not_to be_valid }
    end
  end

  describe 'scopes' do
    it :default_scope do
      a = create(klass, notable_id: 1, created_at: 2.days.ago)
      b = create(klass, notable_id: 2, created_at: 1.day.ago)
      c = create(klass, notable_id: 3, created_at: 3.days.ago)

      expect(model.all).to eq [b, a, c]
    end
  end

  it '#respond_to?' do
    expect(model.new).to respond_to(:notable)
  end
end

