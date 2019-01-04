PostLastTweetJob = Struct.new(:a) do
  DEFAULT_TIME_INTERVAL = 5

  def perform
    return unless Running.status
    cocoroco_to_post = Cocoroco.order(:last_tweeted_at).last
    client.update(cocoroco_to_post.twitter_formated_string)
    cocoroco_to_post.update(last_tweeted_at: DateTime.now)
  end

  def success(job)
    set_next_job
  end

  def error(job, exception)
    binding.pry
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
    interval = Running.interval || DEFAULT_TIME_INTERVAL
    PostLastTweetJob.new.delay(run_at: interval.minutes.from_now).perform
  end
end
