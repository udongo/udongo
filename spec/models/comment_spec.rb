require 'rails_helper'

describe Comment do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }
  let(:instance) { build(klass) }

  # it_behaves_like :parentable
  # it_behaves_like :spammable

  describe 'validations' do
    describe 'presence' do
      it(:commentable_id) { expect(build(klass, commentable_id: nil)).not_to be_valid }
      it(:commentable_type) { expect(build(klass, commentable_type: nil)).not_to be_valid }
      it(:author) { expect(build(klass, author: nil)).not_to be_valid }
      it(:email) { expect(build(klass, email: nil)).not_to be_valid }
      it(:message) { expect(build(klass, message: nil)).not_to be_valid }
    end

    describe 'format' do
      describe 'email' do
        it(:valid) { expect(build(klass, email: 'dave@blimp.be')).to be_valid }
        it(:invalid) { expect(build(klass, email: 'dave@blimp')).not_to be_valid }
      end
    end

    describe 'url' do
      describe 'website' do
        it(:http) { expect(build(klass, website: 'http://google.be')).to be_valid }
        it(:https) { expect(build(klass, website: 'https://google.be')).to be_valid }
        it(:localhost) { expect(build(klass, website: 'http://localhost')).to be_valid }
        it(:ip) { expect(build(klass, website: 'http://127.0.0.1')).to be_valid }
        it(:invalid) { expect(build(klass, website: 'http//localhost')).not_to be_valid }
      end
    end

    describe 'custom' do
      describe 'parent_id' do
        describe 'exists' do
          it :true do
            parent = create(:comment)
            expect(build(klass, parent_id: parent.id)).to be_valid
          end

          it :false do
            expect(build(klass, parent_id: nil)).to be_valid
            expect(build(klass, parent_id: 10)).not_to be_valid
          end
        end
      end
    end
  end

  describe 'defaults' do
    it(:status) { expect(model.new.status).to eq 'pending_moderation' }
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
    expect(model.new).to respond_to(:commentable)
    # TODO add some methods published?
  end

  it '.respond_to?' do
    expect(model).to respond_to(:by_locale)
  end
end

