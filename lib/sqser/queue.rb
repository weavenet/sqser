module Sqser
  class Queue
    def self.queue_url
      @@queue_url
    end

    def self.queue_url=(url)
      @@queue_url = url
    end

    def process(args={})
      Sqser::Job.queue.receive_message(args) do |message|
        job = Sqser::Job.from_message message.body
        job.run_job
      end
    end
  end
end
