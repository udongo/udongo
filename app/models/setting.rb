class Setting < ActiveRecord::Base
  validates :name,
            presence: true,
            uniqueness: { case_sensitive: false }

  def value
    YAML.load read_attribute(:value)
  end

  def value=(value)
    write_attribute :value, value.to_yaml
  end
end
