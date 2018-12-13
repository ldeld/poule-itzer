class TwitterTaskListService
  def run(:delay)
    cocoroco_to_post = Cocoroco.order_by(:tweeted_at).first
    PostTweetService.new(cocoroco_to_post).run
    TwitterTaskListService.new.delay(run_at: delay.minutes.from_now).run
  end
end
