module Sqser
  class Job
    def self.from_message(message)
      job_params = YAML.load message

      job_class = job_params[:job_class]
      job_args  = job_params[:job_args]

      job = initialize_job_class(job_class).new
      job.load_args job_args
      job
    end

    def queue_job(options={})
      self.class.queue.send_message self.to_message, options
    end

    def run_job
      self.run
    end

    def self.queue
      AWS::SQS.new.queues[Sqser::Queue.queue_url]
    end

    def to_message
      job_params = { :job_class => self.class.to_s,
                     :job_args  => self.dump_args }
      YAML.dump job_params
    end

    def dump_args
      instance_variables.map do |i|
        { i => (instance_variable_get i) }
      end
    end

    def load_args(args)
      args.each do |a|
        a.each_pair do |key,value|
          self.instance_variable_set key, value
        end
      end
    end

    private

    def self.initialize_job_class(job_class)
      job_class.split("::").inject(Module) {|acc, val| acc.const_get val}
    end
  end
end
