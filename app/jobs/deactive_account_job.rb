class DeactiveAccountJob
  include Sidekiq::Worker
  queue_as :default

  def perform(user_id)
    p "Run job"
    user = User.find(user_id)
    if user.is_changed_pass
      user.update_attributes(deactived: true)
    end
  end
end
