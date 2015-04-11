require 'rails_helper'

describe Log do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }

  describe 'scopes' do
    it :default_scope do
      a = create(klass, loggable_id: 1, created_at: 2.days.ago)
      b = create(klass, loggable_id: 2, created_at: 1.day.ago)
      c = create(klass, loggable_id: 3, created_at: 3.days.ago)

      expect(Log.all).to eq [b, a, c]
    end
  end

  it '#respond_to?' do
    expect(model.new).to respond_to(:loggable)
  end
end

