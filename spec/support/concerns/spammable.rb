require 'rails_helper'

shared_examples_for :spammable do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }
  let(:zotten_instance) { build(klass) }

  describe 'scopes' do
    before(:each) do
      # TODO include nil
      @a = create(klass, marked_as_spam: true)
      @b = create(klass, marked_as_spam: false)
      @c = create(klass, marked_as_spam: true)
    end

    it(:spam) { expect(model.spam).to eq [@a, @c] }
    it(:not_spam) { expect(model.not_spam).to eq [@b] }
  end

  describe 'defaults' do
    describe 'not set' do
      expect(zotten_instance.marked_as_spam).to be false
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
    zotten_instance.mark_as_spam!
    expect(zotten_instance).to be_marked_as_spam
  end

  it '#unmark_as_spam!' do
    zotten_instance.marked_as_spam = true
    zotten_instance.unmark_as_spam!
    expect(zotten_instance).to_not be_marked_as_spam
  end

  it '.respond_to?' do
    expect(model).to respond_to(:spammable, :spam, :not_spam)
  end

  it '#respond_to?' do
    expect(model.new).to respond_to(:mark_as_spam!, :spam?, :spam!, :ham!)
  end
end
