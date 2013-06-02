require 'spec_helper'

describe Sqser::Queue do
  it "should process jobs from the queue" do
    queue = Sqser::Queue.new
    message_mock = mock 'message'
    queue_mock = mock 'queue'
    Sqser::Job.stub :queue => queue_mock
    queue_mock.should_receive(:receive_message).and_yield message_mock
    job_mock = mock 'job'
    message_mock.stub :body => 'body'
    Sqser::Job.should_receive(:from_message).
               with('body').and_return job_mock
    job_mock.should_receive(:run_job)
    queue.process
  end
end
