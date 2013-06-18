# Examples

## Setup

Set your AWS Secret, Access Keys and SQS Queue URL:

    export AWS_ACCESS_KEY_ID='...'
    export AWS_SECRET_ACCESS_KEY='...'
    export SQS_QUEUE_URL='...'

## Clear Text

### Queue Example Job

    ./clear_text/queue_example_job.rb
    Job queued succesfully.

### Process Example Jobs

    ./clear_text/process_example_job.rb
    My value: testing 123.

## Encrypted

### Queue Example Job

    ./encrypted/queue_example_job.rb
    Job queued succesfully.

### Process Example Jobs

    ./encrypted/process_example_job.rb
    My value: testing 123.
