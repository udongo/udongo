module Concerns
  module Person
    def full_name
      "#{first_name} #{last_name}"
    end

    def short_name
      short = "#{first_name}"
      short << ' ' if first_name.present? && last_name.present?
      short << last_name.to_s.split(' ').map { |n| "#{n[0,1]}." }.join
    end
  end
end
