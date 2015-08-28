require 'udongo/engine'
require 'udongo/config'
require 'udongo/breadcrumb'
require 'jquery-rails'
require 'jquery-ui-rails'
require 'foundation-rails'
require 'simple_form'
require 'acts_as_list'
require 'carrierwave'
require 'reform'
require 'rakismet'
require 'draper'
require 'ransack'
require 'ckeditor'
require 'responders'
require 'will_paginate'
require 'active_model_simulator'

module Udongo
  PATH = File.expand_path('../../', __FILE__)

  class << self
    attr_writer :config
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
