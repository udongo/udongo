class DateRangePickerInput < DatePickerInput
  def data_attributes
    super.reverse_merge!(
      range_picker: range_picker?,
      start: self.options[:start] === true,
      stop: self.options[:stop] === true
    )
  end

  def range_picker?
    self.options[:start] === true || self.options[:stop] === true
  end
end
