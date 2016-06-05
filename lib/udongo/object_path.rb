class Udongo::ObjectPath
  def self.find(object)
    unless object.is_a?(Array)
      return cleanup("#{object.class.name.underscore}_path")
    end

    object.map do |item|
      item.is_a?(Symbol) ? "#{item}" : cleanup(item.class.name.underscore)
    end.join('_') << '_path'
  end

  def self.remove_symbols(object)
    return object unless object.is_a?(Array)
    object.select { |o| !o.is_a?(Symbol) }
  end

  private

  def self.cleanup(value)
    value.to_s.gsub('_decorator', '')
  end
end
