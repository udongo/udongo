class Backend::Navigation::ItemsController < BackendController
  include Concerns::Backend::TranslatableController
  before_action :find_navigation
  before_action :find_model, only: [:edit, :update, :destroy]
  before_action { breadcrumb.add t('b.navigation'), backend_navigations_path }

  def new
    @model = @navigation.items.new
  end

  def create
    @model = @navigation.items.new allowed_params

    if @model.save
      redirect_to backend_navigations_path, notice: t('b.msg.navigation.added')
    else
      render :new
    end
  end

  def update
    if @model.update_attributes allowed_params
      redirect_to backend_navigations_path, notice: t('b.msg.changes_saved')
    else
      render :edit
    end
  end

  def destroy
    @model.destroy
    redirect_to backend_navigations_path, notice: t('b.msg.navigation.deleted')
  end

  private

  def find_navigation
    @navigation = ::Navigation.find params[:navigation_id]
  end

  def find_model
    @model = ::NavigationItem.find params[:id]
  end

  def allowed_params
    params[:navigation_item].permit(:page_id)
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
