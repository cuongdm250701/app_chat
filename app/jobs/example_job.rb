class ExampleJob
  include Sidekiq::Worker
  queue_as :default

  def perform()
    p "hello from ExampleJob #{Time.now().strftime('%F - %H:%M:%S.%L')}"
  end
end
