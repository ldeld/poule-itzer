class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def edit
    @status = Running.status
    @interval = Running.interval
  end

  def run
    Running.status = true
    Running.interval = params[:app][:interval]
    cocoroco_to_post = Cocoroco.next_to_post
    PostLastTweetJob.new(cocoroco_to_post).delay.perform
    redirect_to root_path, notice: 'Application started!'
  end

  def stop
    Running.status = false
    Delayed::Job.destroy_all
    redirect_to root_path, alert: 'Application stopped.'
  end
end
