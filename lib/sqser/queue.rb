module Sqser
  class Queue
    def self.queue_url
      @@queue_url
    end

    def self.queue_url=(url)
      @@queue_url = url
    end

    def process(limit=10)
      Sqser::Job.queue.receive_message(:limit => limit) do |message|
        job = Sqser::Job.from_message message.body
        job.run_job
      end
    end
  end
end
