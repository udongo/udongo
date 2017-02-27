class Backend::AssetsController < Backend::BaseController
  before_action :find_model, only: [:edit, :update, :destroy]
  before_action -> { breadcrumb.add t('b.files'), backend_assets_path }

  def index
    @assets = Asset.order('id DESC')
  end

  def new
    @model = Asset.new
  end

  def create
    @model = Asset.new allowed_params

    if @model.save
      redirect_to backend_assets_path, notice: translate_notice(:added, :file)
    else
      render :new
    end
  end

  def update
    if @model.update_attributes allowed_params
      redirect_to backend_assets_path, notice: translate_notice(:edited, :file)
    else
      render :edit
    end
  end

  def destroy
    # TODO add if deletable?
    @model.destroy
    redirect_to backend_assets_path, notice: translate_notice(:deleted, :file)
  end

  private

  def find_model
    @model = Asset.find params[:id]
  end

  def allowed_params
    params[:asset].permit(:filename, :description)
  end
end
