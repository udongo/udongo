module Concerns
  module Publishable
    extend ActiveSupport::Concern

    included do
      scope :published, ->{ where('published_at < ?', Time.zone.now).order('published_at DESC') }
      scope :not_published, ->{ where('published_at > ? OR published_at IS NULL OR published_at = ?', Time.zone.now, '') }
    end

    def publish!(time = Time.zone.now)
      update_attribute :published_at, time
    end

    def unpublish!
      update_attribute :published_at, nil
    end

    def published?
      published_at && published_at.past?
    end
  end
end
