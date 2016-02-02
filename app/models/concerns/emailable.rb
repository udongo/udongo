module Concerns::Emailable
  extend ActiveSupport::Concern

  def email_vars
    @email_vars ||= "Udongo::EmailVars::#{self.class.name}".constantize.new self
  end
end
