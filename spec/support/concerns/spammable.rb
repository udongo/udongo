require 'rails_helper'

shared_examples_for :spammable do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }

  describe 'scopes' do
    before(:each) do
      @a = create(klass, marked_as_spam: nil)
      @b = create(klass, marked_as_spam: false)
      @c = create(klass, marked_as_spam: true)
    end

    it(:spam) { expect(model.spam).to eq [@c] }
    it(:not_spam) { expect(model.not_spam).to eq [@a, @b] }
  end

  describe 'defaults' do
    it 'not set' do
      expect(build(klass)).not_to be_marked_as_spam
    end

    describe 'set' do
      it :true do
        expect(build(klass, marked_as_spam: true)).to be_marked_as_spam
      end

      it :false do
        expect(build(klass, marked_as_spam: false)).not_to be_marked_as_spam
      end
    end
  end

  it '#mark_as_spam!' do
    object = build(klass)
    object.mark_as_spam!
    expect(object).to be_marked_as_spam
  end

  it '#unmark_as_spam!' do
    object = build(klass, marked_as_spam: true)
    object.unmark_as_spam!
    expect(object).not_to be_marked_as_spam
  end

  it '.respond_to?' do
    expect(model).to respond_to(:spam, :not_spam)
  end

  it '#respond_to?' do
    expect(model.new).to respond_to(:mark_as_spam!)
  end
end
