require 'rails_helper'

describe Comment do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }
  let(:instance) { build(klass) }

  it_behaves_like :parentable
  it_behaves_like :spammable
  it_behaves_like :locale

  describe 'validations' do
    describe 'presence' do
      it(:author) { expect(build(klass, author: nil)).not_to be_valid }
      it(:email) { expect(build(klass, email: nil)).not_to be_valid }
      it(:message) { expect(build(klass, message: nil)).not_to be_valid }
    end

    describe 'status' do
      it(:invalid) { expect(build(klass, status: 'foo')).not_to be_valid }

      it :valid do
        comment = build(klass)

        ::Comment::STATUSES.each do |status|
          comment.status = status
          expect(comment).to be_valid
        end
      end
    end

    describe 'email' do
      it(:valid) { expect(build(klass, email: 'dave@blimp.be')).to be_valid }
      it(:invalid) { expect(build(klass, email: 'dave@blimp')).not_to be_valid }
    end

    describe 'website' do
      it(:http) { expect(build(klass, website: 'http://google.be')).to be_valid }
      it(:https) { expect(build(klass, website: 'https://google.be')).to be_valid }
      it(:localhost) { expect(build(klass, website: 'http://localhost')).to be_valid }
      it(:ip) { expect(build(klass, website: 'http://127.0.0.1')).to be_valid }
      it(:invalid) { expect(build(klass, website: 'http//localhost')).not_to be_valid }
    end
  end

  describe 'defaults' do
    it 'no status provided' do
      expect(model.new.status).to eq 'pending_moderation'
    end

    it 'status provided' do
      expect(model.new(status: 'published').status).to eq 'published'
    end
  end

  it '#publish!' do
    instance.publish!
    expect(instance).to be_published
  end

  it '#unpublish!' do
    instance.unpublish!
    expect(instance).not_to be_published
  end

  it '#respond_to?' do
    expect(model.new).to respond_to(:commentable, :published?, :publish!, :unpublish!)
  end
end
