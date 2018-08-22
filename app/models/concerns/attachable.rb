module Concerns
  module Attachable
    extend ActiveSupport::Concern

    included do
      has_many :attachments, as: :attachable, dependent: :destroy
    end
  end
end
