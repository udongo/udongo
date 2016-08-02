require 'jquery-rails'
require 'jquery-ui-rails'
require 'simple_form'
require 'acts_as_list'
require 'carrierwave'
require 'draper'
require 'ransack'
require 'ckeditor'
require 'responders'
require 'will_paginate'
require 'virtus'

module Udongo
  PATH = File.expand_path('../../', __FILE__)

  class << self
    attr_writer :config

    Dir.glob("#{PATH}/lib/udongo/**/*.rb").each do |file|
      require file
    end
  end

  def self.config
    @config ||= Config.new
  end

  def self.reset_config
    @config = Config.new
  end

  def self.configure
    yield(config)
  end
end
