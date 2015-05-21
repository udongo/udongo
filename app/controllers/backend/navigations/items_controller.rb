class Backend::Navigations::ItemsController < BackendController
  include Concerns::Backend::PositionableController
  before_action :find_model, only: [:destroy]

  def destroy
    @model.destroy
    redirect_to backend_navigation_items_path,
      notice: translate_notice(:deleted, :navigation_item)
  end

  def index
    @lists = NavigationList.all
  end

  def new
    @model = NavigationItem.new
  end

  def create
    @model = NavigationItem.new allowed_params

    if @model.save
      redirect_to new_backend_navigation_item_path(list_id: @model.list_id),
        notice: translate_notice(:added, :navigation_item)
    else
      render :new
    end
  end

  private

  def allowed_params
    params.require(:navigation_item).permit(:page_id, :list_id)
  end

  def find_model
    @model = NavigationItem.find params[:id]
  end
end
