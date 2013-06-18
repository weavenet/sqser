module Sqser
  class Queue
    def self.queue_url
      @@queue_url
    end

    def self.queue_url=(url)
      @@queue_url = url
    end

    def process(args={})
      @secret = args.delete :secret

      Sqser::Job.queue.receive_message(args) do |message|
        job = Sqser::Job.from_message message_body(message)
        job.run_job
      end
    end

    private

    def message_body(message)
      body = Base64.decode64 message.body
      @secret ? Encryptor.decrypt(body, :key => @secret) : body
    end
  end
end
