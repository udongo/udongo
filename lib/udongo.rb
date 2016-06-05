require 'udongo/engine'
require 'udongo/config'
require 'udongo/breadcrumb'
require 'udongo/meta_info'
require 'udongo/object_path'
require 'udongo/crypt'
require 'udongo/cryptography'
require 'udongo/active_model_simulator'
require 'udongo/email_vars_parser'
require 'udongo/email_vars/form_submission'
require 'udongo/email_vars/address'
require 'jquery-rails'
require 'jquery-ui-rails'
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
require 'virtus'

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
