class Backend::TagboxController < BackendController
  def index
    tags = Tag.by_locale(locale).pluck(:name).map do |name|
      { label: name, value: name }
    end

    render json: tags
  end

  def create
    create_tag if tag_creatable?
    render json: { tag: params[:tag], valid: item_tagged?(find_tag) }
  end

  def destroy
    tag = find_tag
    find_model.tagged_items.where(tag_id: tag.id).destroy_all if tag.present?
    render json: { success: true }
  end

  private

  def find_model
    @model ||= params[:taggable_type].to_s.constantize.find params[:taggable_id]
  end

  def find_tag
    Tag.find_by locale: params[:locale], name: params[:tag]
  end

  def tag_creatable?
    !Tag.exists?(tag_params) && Udongo.config.tags.allow_new?
  end

  def create_tag
    Tag.create! tag_params
  end

  def tag_params
    {
      locale: params[:locale],
      name: params[:tag],
      slug: params[:tag].parameterize
    }
  end

  def item_tagged?(tag)
    return false unless tag
    find_model.tagged_items.create tag: tag
    true
  end
end
