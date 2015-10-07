class Backend::Navigation::ItemsController < BackendController
  before_action :find_navigation
  before_action :find_model, only: [:edit, :update, :destroy]
  before_action { breadcrumb.add t('b.navigation'), backend_navigations_path }

  # TODO use @model
  def new
    @item = @navigation.items.new
  end

  # TODO use @model
  def create
    @item = @navigation.items.new allowed_params

    if @item.save
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
    @model = @navigation.items.find params[:id]
  end

  def allowed_params
    params[:navigation_item].permit(:page_id)
  end
end
