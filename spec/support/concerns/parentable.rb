require 'rails_helper'

shared_examples_for :parentable do
  let(:model) { described_class }
  let(:klass) { model.to_s.underscore.to_sym }

  let(:a) { create(klass) }
  let(:b) { create(klass, parent: a) }
  let(:c) { create(klass, parent: a) }

  it '#children' do
    expect(a.children).to eq [b, c]
  end

  it '#parent' do
    expect(b.parent).to eq a
  end

  describe '#depth' do
    let(:d) { create(klass, parent_id: b.id) }

    it(:naught) { expect(a.depth).to eq 0 }
    it(:one) { expect(b.depth).to eq 1 }
    it(:two) { expect(d.depth).to eq 2 }
  end

  describe '#parentable?' do
    it(:true) { expect(a.parentable?).to be true }
  end

  describe 'parents' do
    it :basic do
      expect(b.parents).to eq [b, a]
    end

    it :include_self do
      expect(b.parents(include_self: false)).to eq [a]
    end
  end

  describe '.flat_tree' do
    context 'no records' do
      it :empty do
        expect(model.flat_tree).to eq []
      end
    end

    context 'records' do
      it :results do
        articles = create(klass)
        blog = create(klass)
        blog_archive = create(klass, parent: blog)
        blog_archive_current_year = create(klass, parent: blog_archive)
        blog_archive_last_year = create(klass, parent: blog_archive)
        blog_tags = create(klass, parent: blog)
        articles_comments = create(klass, parent: articles)

        expect(model.flat_tree).to eq [
          articles, articles_comments, blog, blog_archive,
          blog_archive_current_year, blog_archive_last_year, blog_tags
        ]
      end
    end
  end

  it '#respond_to?' do
    expect(model.new).to respond_to(:children, :parent, :depth, :parentable?, :parents)
  end

  it '.respond_to' do
    expect(model).to respond_to(:flat_tree)
  end
end
