# frozen_string_literal: true
source "https://rubygems.org"

# gem "rails"
gem "cocoapods", "1.1.1"
gem "cocoapods-keys", "1.7.0"
gem "slather", "2.3.0"
gem "fastlane", "2.32.1"
gem 'danger'
gem "danger-slather"

plugins_path = File.join(File.dirname(__FILE__), 'fastlane', 'Pluginfile')
eval_gemfile(plugins_path) if File.exist?(plugins_path)
