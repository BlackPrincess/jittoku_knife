# coding: utf-8

module JittokuKnife::Process
  def self.configure(&block)
    yield @config ||= JittokuKnife::Process::Configuration.new
  end

  def self.config
    @config ||= JittokuKnife::Process::Configuration.new
    @config
  end

  class Configuration
    include ActiveSupport::Configurable

    config_accessor :pid_dir


    configure do |config|
      # For Rails
      # "#{Rails.application.root}/tmp/pids"
      config.pid_dir = '/tmp'
    end
  end
end