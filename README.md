# SQSer

SQSer is a library to perform job queuing and execution via an Amazon SQS Queue.

It provides a class which can be used as a parent to job classes which can be queued.

The job class and instance variables are placed in a queue.  When the job is ran, the object is created and variables loaded from the message.

It supports queueing multiple types of jobs to a single queue.

## Installation

    gem install sqser

## Usage

### Setup

Set your AWS Secret and Access Keys:

    export AWS_ACCESS_KEY_ID='...'
    export AWS_SECRET_ACCESS_KEY='...'

### Queuing Jobs

Require sqser and set the queue_url

    require 'sqser'
    Sqser::Queue.queue_url = 'https://sqs.us-west-2.amazonaws.com/123456789012/my-dev-queue'

Create a Job Class which inherits from Sqser::Job with attr_accesors for instance variables to be persisted in SQS.

    class TestJob < Sqser::Job
      attr_accessor :value

      def run
        puts "My value: #{@value}."
      end
    end

Create a new job from this class and set the instance values.

    job = TestJob.new
    job.value = 'testing 123'

Queue the job in SQS.

    job.queue_job

### Running Jobs

To process jobs, create a new Sqser::Queue instance and call process.

    queue = Sqser::Queue.new
    queue.process

## Examples

Checkout the examples folder.

## Attribution

Thanks to @bradly and @vsomayaji for providing original inspiration.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
