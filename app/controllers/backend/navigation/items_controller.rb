class Backend::Navigation::ItemsController < BackendController
  include Concerns::Backend::TranslatableController
  include Concerns::Backend::PositionableController

  before_action :find_navigation
  before_action :find_model, only: [:edit, :update, :destroy]
  before_action { breadcrumb.add t('b.navigation'), backend_navigations_path }

  def new
    @form = Backend::NavigationItemForm.new(@navigation.items.new.decorate)
  end

  def create
    @form = Backend::NavigationItemForm.new(@navigation.items.new.decorate)

    if @form.save params[:navigation_item]
      redirect_to backend_navigations_path, notice: translate_notice(:added, :navigation_item)
    else
      render :new
    end
  end

  def edit
    @form = Backend::NavigationItemForm.new(@model)
  end

  def update
    @form = Backend::NavigationItemForm.new(@model)

    if @form.save params[:navigation_item]
      redirect_to backend_navigations_path, notice: translate_notice(:changes_saved)
    else
      render :edit
    end
  end

  def destroy
    @model.destroy
    redirect_to backend_navigations_path, notice: translate_notice(:deleted, :navigation_item)
  end

  private

  def find_navigation
    @navigation = ::Navigation.find params[:navigation_id]
  end

  def find_model
    @model = NavigationItem.find(params[:id]).decorate
  end

  def translation_form
    Backend::NavigationItemTranslationForm.new(
      navigation_item: @model,
      translation: @model.translation(params[:translation_locale])
    )
  end

  def translatable_path
    edit_translation_backend_navigation_item_path(
      @navigation,
      @model,
      params[:translation_locale]
    )
  end
end
