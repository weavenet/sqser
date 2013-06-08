require 'rubygems'
require 'bundler/setup'

require 'sqser'

class TestJob < Sqser::Job
  attr_accessor :value

  protected

  def run
    "testing 123 #{@value}"
  end
end

RSpec.configure do |config|
end
