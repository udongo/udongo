require 'rails_helper'

describe PageDecorator do
  describe '#options_for_parents' do
    before(:each) do
      @a = create(:page)
      @b = create(:page, parent: @a)
      @c = create(:page, parent: @a)
    end

    it 'disabled' do
      result = @a.decorate.options_for_parents(disabled: @b.id)
      expect(result).to eq [["Foo", 5], ["- Foo", 6], ["- Foo", 7]]
    end

    it 'selected' do
      result = @b.decorate.options_for_parents
      expect(result).to eq [["Foo", 2], ["- Foo", 3], ["- Foo", 4]]
    end
  end

  describe '#path' do
    context 'without routes' do
      before(:each) do
        allow(Udongo.config).to receive(:prefix_routes_with_locale?) { true }

        @team = create(:page)
        @team.seo(:nl).slug = 'team'
        @team.seo(:nl).save

        @devs = create(:page, parent: @team)
        @devs.seo(:nl).slug = 'devs'
        @devs.seo(:nl).save

        @foo = create(:page, parent: @devs)
        @foo.seo(:nl).slug = 'foo'
        @foo.seo(:nl).save
      end

      describe 'first level' do
        it 'with locale prefix' do
          expect(@team.decorate.path(locale: :nl)).to eq '/nl/team'
        end

        it 'without locale prefix' do
          allow(Udongo.config).to receive(:prefix_routes_with_locale?) { false }
          expect(@team.decorate.path(locale: :nl)).to eq '/team'
        end
      end

      it 'second level' do
        expect(@devs.decorate.path(locale: :nl)).to eq '/nl/team/devs'
      end

      it 'third level' do
        expect(@foo.decorate.path(locale: :nl)).to eq '/nl/team/devs/foo'
      end
    end

    context 'with routes' do
      it 'first level' do
        page = create(:page, route: 'backend_path')
        expect(page.decorate.path).to eq '/backend'
      end

      describe 'second level' do
        it 'with route / without route' do
          backend = create(:page, route: 'backend_path')

          pages = create(:page, parent: backend)
          pages.seo.slug = 'pages'
          pages.seo.save

          expect(pages.decorate.path).to eq '/backend/pages'
        end

        it 'without route / with route' do
          backend = create(:page)
          backend.seo.slug = 'does-not-matter'
          backend.seo.save

          pages = create(:page, parent: backend, route: 'backend_pages_path')
          expect(pages.decorate.path).to eq '/backend/pages'
        end
      end

      describe 'third level' do
        it 'with route / without route / without route' do
          backend = create(:page, route: 'backend_path')

          pages = create(:page, parent: backend)
          pages.seo.slug = 'pages'
          pages.seo.save

          subpage = create(:page, parent: pages)
          subpage.seo.slug = 'subpage'
          subpage.seo.save

          expect(subpage.decorate.path).to eq '/backend/pages/subpage'
        end

        it 'without route / with route / without route' do
          backend = create(:page)
          backend.seo.slug = 'does-not-matter'
          backend.seo.save

          pages = create(:page, parent: backend, route: 'backend_pages_path')

          subpage = create(:page, parent: pages)
          subpage.seo.slug = 'subpage'
          subpage.seo.save

          expect(subpage.decorate.path).to eq '/backend/pages/subpage'
        end

        it 'without route / without route / with route' do
          backend = create(:page)
          backend.seo.slug = 'does-not-matter'
          backend.seo.save

          pages = create(:page, parent: backend)
          pages.seo.slug = 'does-not-matter'
          pages.seo.save

          subpage = create(:page, parent: pages, route: 'backend_pages_path')
          expect(subpage.decorate.path).to eq '/backend/pages'
        end
      end
    end
  end

  it '#respond_to?' do
    expect(create(:page).decorate).to respond_to(:options_for_parents, :path)
  end
end
