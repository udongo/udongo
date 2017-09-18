class Udongo::FlexibleContent::DuplicateLocale
  def initialize(object, source_locale, destination_locale)
    @object = object
    @source_locale = source_locale
    @destination_locale = destination_locale
  end

  def execute!
    check_for_flexible_content!
    check_for_different_locales!
    clear_destination_content!

    # TODO add transaction...!

    @object.content_rows.by_locale(@source_locale).each do |source_row|
      new_row = duplicate_row(source_row)

      source_row.columns.each do |source_column|
        duplicate_column(new_row, source_column)
      end
    end
  end

  private

  def check_for_flexible_content!
    return if @object.respond_to?(:flexible_content?) && @object.flexible_content?
    raise 'The object you provided does not have the FlexibleContent concern included.'
  end

  def check_for_different_locales!
    if @source_locale.to_s == @destination_locale.to_s
      raise "The source and destination locale are the same (#{@source_locale})"
    end
  end

  def clear_destination_content!
    @object.content_rows.by_locale(@destination_locale).destroy_all
  end

  def duplicate_row(source)
    @object.content_rows.create!(
      locale: @destination_locale,
      full_width: source.full_width?,
      horizontal_alignment: source.horizontal_alignment,
      vertical_alignment: source.vertical_alignment,
      background_color: source.background_color,
      no_gutters: source.no_gutters?,
      padding_top: source.padding_top,
      padding_bottom: source.padding_bottom,
      margin_top: source.margin_top,
      margin_bottom: source.margin_bottom,
      position: source.position
    )
  end

  def duplicate_column(new_row, source_column)
    widget = duplicate_widget(source_column.content)

    new_row.columns.create!(
      width_xs: source_column.width_xs,
      width_sm: source_column.width_sm,
      width_md: source_column.width_md,
      width_lg: source_column.width_lg,
      width_xl: source_column.width_xl,
      position: source_column.position,
      content: widget
    )
  end

  def duplicate_widget(source)
    if source.class == ContentText
      ContentText.create!(content: source.content)

    elsif source.class == ContentPicture
      ContentPicture.create!(
        asset_id: source.asset_id,
        caption: source.caption,
        url: source.url
      )
    elsif source.class == ContentVideo
      ContentVideo.create!(
        url: source.url,
        caption: source.caption,
        aspect_ratio: source.aspect_ratio
      )
    elsif source.class == ContentSlideshow
      ContentSlideshow.create!(
        image_collection_id: source.image_collection_id,
        autoplay: source.autoplay,
        slide_interval: source.slide_interval
      )
    elsif source.class == ContentForm
      ContentForm.create!(form_id: source.form_id)
    end
  end
end
