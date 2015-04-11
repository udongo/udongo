require 'rails_helper'

shared_examples_for :spammable do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }
  let(:instance) { build(klass) }

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
    describe 'not set' do
      expect(instance).not_to be_marked_as_spam
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
    instance.mark_as_spam!
    expect(instance).to be_marked_as_spam
  end

  it '#unmark_as_spam!' do
    instance.marked_as_spam = true
    instance.unmark_as_spam!
    expect(instance).not_to be_marked_as_spam
  end

  it '.respond_to?' do
    expect(model).to respond_to(:spammable, :spam, :not_spam)
  end

  it '#respond_to?' do
    expect(model.new).to respond_to(:mark_as_spam!, :spam?, :spam!, :ham!)
  end
end
