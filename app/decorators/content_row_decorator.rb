class ContentRowDecorator < Draper::Decorator
  delegate_all

  # If the max. column count for the biggest screen medium is met, we can safely
  # assume no more additional columns are needed.
  def column_limit_reached?
    column_width_calculator.total(:width_xl) >= 12
  end
end
