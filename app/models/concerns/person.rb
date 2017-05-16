module Concerns
  module Person
    def full_name
      "#{first_name} #{last_name}"
    end

    def short_name
      s = ''
      s << "#{first_name}" if first_name.present?
      s << ' ' if first_name.present? && last_name.present?

      last_name.to_s.split(' ').each do |chunk|
        s << chunk[0,1]
        s << '.'
      end

      s
    end
  end
end
