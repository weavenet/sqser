# Example

## Setup

Set your AWS Secret, Access Keys and SQS Queue URL:

    export AWS_ACCESS_KEY_ID='...'
    export AWS_SECRET_ACCESS_KEY='...'
    export SQS_QUEUE_URL='...'

## Queue Example Job

    ./queue_example_job.rb
    Job queued succesfully.

## Process Example Jobs

    ./process_example_job.rb
    D, [2013-06-08T07:38:43.041768 #6197] DEBUG -- : Retrieved job lksdjflsdkj from queue.
    My value: testing 123.
