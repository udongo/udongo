class DateRangePickerInput < DatePickerInput
  def data_attributes
    super.reverse_merge!(
      range_picker: range_picker?,
      start: self.options[:start],
      stop: self.options[:stop]
    )
  end

  def range_picker?
    self.options[:start].present? || self.options[:stop].present?
  end
end
