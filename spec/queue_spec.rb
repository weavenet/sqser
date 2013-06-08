require 'spec_helper'

describe Sqser::Queue do
  before do
    @message_mock = mock 'message'
    @queue_mock   = mock 'queue'
    @job_mock     = mock 'job'

    @message_mock.stub :body => 'body'
    Sqser::Job.stub :queue => @queue_mock
    Sqser::Job.should_receive(:from_message).
               with('body').and_return @job_mock

    @queue = Sqser::Queue.new
  end

  it "should process jobs from the queue" do
    @queue_mock.should_receive(:receive_message).with({}).
                and_yield @message_mock
    @job_mock.should_receive(:run_job)
    @queue.process
  end

  it "should set visibility timeout on job processed" do
    @queue_mock.should_receive(:receive_message).with(:visibility_timeout => 180).
                and_yield @message_mock
    @job_mock.should_receive(:run_job)
    @queue.process :visibility_timeout => 180
  end

end
