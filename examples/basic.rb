#!/usr/bin/env ruby

require 'sqser'

# Set the queue URL
Sqser::Queue.queue_url = ENV['SQS_QUEUE_URL']

# Create new class of job
class TestJob < Sqser::Job
  attr_accessor :value

  def run
    puts "My value: #{@value}."
  end
end

# Create and queue a job
job = TestJob.new
job.value = 'testing 123'
job.queue_job

# Sleep for consistency in example
sleep 10

# Retrieve and run queue jobs
queue = Sqser::Queue.new
queue.process
