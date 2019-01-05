require 'open-uri'
PostLastTweetJob = Struct.new(:cocoroco) do
  DEFAULT_TIME_INTERVAL = 5

  def perform
    return unless Running.status
    if cocoroco.attached_image_url
      s3 = Aws::S3::Resource.new(region: 'eu-west-3')
      obj = s3.bucket(SECRETS['aws_bucket']).object(cocoroco.attached_image_url)
      image_path = open(obj.public_url).path
      client.update_with_media(cocoroco.twitter_formated_string, image_path)
    else
      client.update(cocoroco.twitter_formated_string)
    end

    cocoroco.update(last_tweeted_at: DateTime.now)
  end

  def success(job)
    interval = Running.interval || DEFAULT_TIME_INTERVAL
    cocoroco_to_post = Cocoroco.next_to_post
    PostLastTweetJob.new(cocoroco_to_post).delay(run_at: interval.minutes.from_now).perform
  end

   def error(job, exception)
    cocoroco.update(last_tweeted_at: nil)
  end

  private

  def client
    Twitter::REST::Client.new do |config|
      config.consumer_key        = SECRETS['twitter_consumer_key']
      config.consumer_secret     = SECRETS['twitter_consumer_secret']
      config.access_token        = SECRETS['twitter_access_token']
      config.access_token_secret = SECRETS['twitter_access_token_secret']
    end
  end
end
