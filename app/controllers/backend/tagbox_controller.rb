class Backend::TagboxController < BackendController
  def index
    tags = ::Tag.by_locale(locale).pluck(:name).map do |name|
      { label: name, value: name }
    end

    render json: tags
  end

  def create
    create_tag if tag_creatable?
    tag = find_model.tagged_items.create tag: find_tag
    render json: { tag: params[:tag], valid: tag.valid? }
  end

  def destroy
    find_model.tagged_items.where(tag_id: find_tag.id).destroy_all
    render json: { success: true }
  end

  private

  def find_model
    @model ||= params[:taggable_type].to_s.constantize.find params[:taggable_id]
  end

  def find_tag
    ::Tag.find_by locale: params[:locale], name: params[:tag]
  end

  def tag_creatable?
    # TODO: do something with params[:taggable_type] to check for
    !::Tag.exists?(tag_params) && Udongo.config.allow_new_tags?
  end

  def create_tag
    ::Tag.create! tag_params
  end

  def tag_params
    {
      locale: params[:locale],
      name: params[:tag],
      slug: params[:tag].parameterize
    }
  end
end
