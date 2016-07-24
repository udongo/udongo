class QueuedTask < ApplicationRecord
  validates :klass, presence: true

  serialize :data, Hash

  scope :locked, -> { where(locked: true) }
  scope :not_locked, -> { where('locked = 0 OR locked IS NULL') }

  def lock!
    update_attribute :locked, true
  end

  def unlock!
    update_attribute :locked, false
  end

  def run!
    klass.constantize.new(data).run!
  end

  def self.queue(klass, data)
    create!(klass: klass, data: data)
  end

  def self.queue_unless_already_queued(klass, data)
    if where(klass: klass.to_s).where('data = ?', data.to_yaml).empty?
      self.queue(klass.to_s, data)
    end
  end

  def dequeue!
    destroy
  end

  def process!
    lock!

    begin
      run!
      dequeue!
    rescue
      raise
    ensure
      unlock! unless destroyed?
    end
  end
end
