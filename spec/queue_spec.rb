require 'spec_helper'

describe Sqser::Queue do
  before do
    @message_mock = mock 'message'
    @queue_mock   = mock 'queue'
    @job_mock     = mock 'job'

    Sqser::Job.stub :queue => @queue_mock
    @queue = Sqser::Queue.new
  end

  describe "#run_job" do
    describe "un-encrypted" do
      before do
        @message_mock.stub :body => 'body'
        Sqser::Job.should_receive(:from_message).with('body').and_return @job_mock
      end

      it "should process jobs from the queue" do
        @queue_mock.should_receive(:receive_message).with({}).and_yield @message_mock
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

    describe "encrypted" do
      before do
        @secret = 'test1234'
        @message_mock.stub :body => Encryptor.encrypt('body', :key => @secret)
      end

      it "should decrypt job if secret provided" do
        Sqser::Job.should_receive(:from_message).with('body').and_return @job_mock
        @queue_mock.should_receive(:receive_message).with({}).and_yield @message_mock
        @job_mock.should_receive(:run_job)
        @queue.process :secret => @secret
      end

      it "should raise an OpenSSL::Cipher::CipherError error if the secret is invalid" do
        @queue_mock.should_receive(:receive_message).with({}).and_yield @message_mock
        expect { @queue.process :secret => 'bad_secret' }.to raise_error OpenSSL::Cipher::CipherError
      end
    end
  end

end
