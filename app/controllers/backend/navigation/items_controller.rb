class Backend::Navigation::ItemsController < Backend::BaseController
  include Concerns::Backend::TranslatableController
  include Concerns::Backend::PositionableController

  before_action :find_navigation
  before_action :find_model, only: [:edit, :update, :destroy]
  before_action { breadcrumb.add t('b.navigation'), backend_navigations_path }

  def new
    @model = @navigation.items.new.decorate
  end

  def create
    @model = @navigation.items.new(allowed_params).decorate

    if @model.save
      redirect_to backend_navigations_path, notice: translate_notice(:added, :navigation_item)
    else
      render :new
    end
  end

  def update
    if @model.update_attributes allowed_params
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

  def allowed_params
    params[:navigation_item].permit(:page_id, :extra)
  end

  def translation_form
    Backend::NavigationItemTranslationForm.new(
      @model, @model.translation(params[:translation_locale])
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
