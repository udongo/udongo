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

    @object.content_rows.by_locale(@source_locale).each do |source_row|
      new_row = duplicate_row(source_row)

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
end
