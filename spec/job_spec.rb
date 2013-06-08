require 'spec_helper'

describe Sqser::Job do
  before do
    @queue_mock = mock 'queue mock'
    @queue_url  = 'https://sqs.aws.com/id/name'
    @sqs_stub   = stub 'sqs', :queues => { @queue_url => @queue_mock }

    AWS::SQS.stub :new => @sqs_stub
    Sqser::Queue.queue_url = @queue_url

    @test_job       = TestJob.new
    @value          = 'test_value'
    @test_job.value = @value
  end

  it "should queue a job" do
    @queue_mock.should_receive(:send_message).with @test_job.to_message, {}
    @test_job.queue_job
  end

  it "should queue a job and set delay_secondst" do
    @queue_mock.should_receive(:send_message).
                with @test_job.to_message, :delay_seconds => 180
    @test_job.queue_job :delay_seconds => 180
  end

  it "should call run on the parent class of a job pulled from the queue" do
    @test_job.should_receive(:run)
    @test_job.run_job
  end

  it "should create a message based off the given class" do
    message = YAML.dump({ :job_class => TestJob.to_s,
                          :job_args  => [{ :@value => 'test_value'}] })
    @test_job.to_message.should == message
  end

  it "should load the given class and args from a message" do
    message = @test_job.to_message
    message_from_job = TestJob.from_message(message)
    message_from_job.run_job.should == "testing 123 #{@value}"
  end

  it "should not raise an error when instance variables exist which are not exposed via attr_accessor" do
    @test_job.load_args [{ :@private_val => 'test123' }]
    @test_job.instance_variables.include?(:@private_val).should be_true
  end

end
