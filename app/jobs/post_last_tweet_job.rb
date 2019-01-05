require 'open-uri'
PostLastTweetJob = Struct.new(:cocoroco) do
  DEFAULT_TIME_INTERVAL = 5

  def perform
    return unless Running.status
    image_path = cocoroco.attached_image_url? ? open(cocoroco.attached_image_url).path : nil
    tweet = cocoroco.twitter_formated_string
    if tweet.length < 240
      post_tweet(tweet, image_path)
    else
      tweets = splitted_string(tweet)
      tweets.reverse.each_with_index do |tw, i|
        s_tweet = "#{tweets.length - i}/#{tweets.length}: " + tw
        image_path = nil if i != 0 # Only post image on first tweet
        s_tweet += ' ...' if i == tweets.length - 1
        post_tweet(s_tweet, image_path)
      end
    end

    cocoroco.update(last_tweeted_at: DateTime.now)
  end

  def post_tweet(string, media = nil)
    if media
      client.update_with_media(string, media)
    else
      client.update(string)
    end
  end

  def splitted_string(str)
    curr_str = ''
    strings = []
    str.split(' ').each do |word|
      new_string = curr_str + ' ' + word
      if new_string.length > 210
        strings << curr_str
        curr_str = ' '
      else
        curr_str = new_string
      end
    end
    strings << curr_str
    strings
  end


  def success(job)
    interval = Running.interval || DEFAULT_TIME_INTERVAL
    cocoroco_to_post = Cocoroco.next_to_post
    PostLastTweetJob.new(cocoroco_to_post).delay(run_at: interval.minutes.from_now).perform
  end

  def error(job, exception)
    binding.pry
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
