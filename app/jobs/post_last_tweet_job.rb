class PostLastTweetJob < ApplicationJob
  queue_as :default

  def perform
    return unless Running.status
    cocoroco_to_post = Cocoroco.order(:last_tweeted_at).first
    client.update(cocoroco_to_post.twitter_formated_string)
    cocoroco_to_post.update(last_tweeted_at: DateTime.now)

    set_next_job
  end

  private

  def client
    # Ugly work_around on missing secrets conf
    secrets = YAML.load(Rails::Secrets.read)

    Twitter::REST::Client.new do |config|
      config.consumer_key        = secrets['twitter_consumer_key']
      config.consumer_secret     = secrets['twitter_consumer_secret']
      config.access_token        = secrets['twitter_access_token']
      config.access_token_secret = secrets['twitter_access_token_secret']
    end
  end

  def set_next_job
    interval = Running.interval || 5
    PostLastTweetJob.create(run_at: interval.minutes.from_now)
  end
end
