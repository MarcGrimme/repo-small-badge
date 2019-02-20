# frozen_string_literal: true

require 'simplecov'
require 'byebug'

SimpleCov.start do
  module SimpleCovSmallBadge
    class Formatter
    end
  end

  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new(
    [
      SimpleCov::Formatter::HTMLFormatter,
      SimpleCovSmallBadge::Formatter
    ]
  )
end

SimpleCov.minimum_coverage 100

# require 'simplecov-small-badge'
require 'repo_small_badge'
require 'simplecov_small_badge'
require 'rubygems'
require 'bundler/setup'

Dir[File.join('./spec/support/*.rb')].each { |f| require f }

RSpec.configure do |config|
  # some (optional) config here
end
