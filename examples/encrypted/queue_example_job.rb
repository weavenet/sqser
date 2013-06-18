#!/usr/bin/env ruby

require 'sqser'
require File.join(__FILE__, '..', 'example_job')

Sqser::Queue.queue_url = ENV['SQS_QUEUE_URL']

job = ExampleJob.new
job.value = 'testing 123'
job.queue_job :secret => 'this-is-a-secret'

puts "Job queued succesfully."
