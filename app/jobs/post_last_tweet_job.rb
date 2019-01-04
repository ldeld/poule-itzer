PostLastTweetJob = Struct.new(:a) do
  DEFAULT_TIME_INTERVAL = 5

  def perform
    return unless Running.status
    cocoroco = Cocoroco.last
    client.update(cocoroco.twitter_formated_string, media_ids: cocoroco.attached_image_url)
    cocoroco.update(last_tweeted_at: DateTime.now)
  end

  def success(job)
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
    interval = Running.interval || DEFAULT_TIME_INTERVAL
    PostLastTweetJob.new.delay(run_at: interval.minutes.from_now).perform
  end
end
