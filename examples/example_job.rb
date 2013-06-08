class ExampleJob < Sqser::Job
  attr_accessor :value

  def run
    puts "My value: #{@value}."
  end
end
