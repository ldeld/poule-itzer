module Admin
  class CocorocosController < Admin::ApplicationController
    # To customize the behavior of this controller,
    # you can overwrite any of the RESTful actions. For example:
    #
    # def index
    #   super
    #   @resources = Cocoroco.
    #     page(params[:page]).
    #     per(10)
    # end
    def create
      @cocoroco = Cocoroco.new(cocoroco_params)
      upload_image_to_twitter

      if @cocoroco.save
        redirect_to(
          [namespace, @cocoroco],
          notice: translate_with_resource("create.success"),
        )
      else
        render :new, locals: {
          page: Administrate::Page::Form.new(dashboard, @cocoroco),
        }
      end
    end

    private

    def upload_image_to_twitter
      image = params[:cocoroco][:attached_image_url]&.tempfile
      return unless image
      media_id = client.send(:upload, image.path)[:media_id_string]
      @cocoroco.attached_image_url = media_id
    end

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

    def cocoroco_params
      params.require(:cocoroco).permit(:content, :author)
    end
  end
end
