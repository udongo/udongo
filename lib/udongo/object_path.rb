class Udongo::ObjectPath
  def self.find(object)
    unless object.is_a?(Array)
      return "#{object.class.name.underscore}_path".gsub('_decorator', '')
    end

    object.map do |item|
      item.is_a?(Symbol) ? "#{item}" : "#{item.class.name.underscore}".gsub('_decorator', '')
    end.join('_') << '_path'
  end

  def self.remove_symbols(object)
    return object unless object.is_a?(Array)
    object.select { |o| !o.is_a?(Symbol) }
  end
end
