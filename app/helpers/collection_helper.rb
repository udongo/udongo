module CollectionHelper
  def options_for_collection(field_name, collection)
    collection.map do |item|
      [t("g.collections.#{field_name}.#{item}"), item]
    end
  end
end
