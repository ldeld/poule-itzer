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
      upload_image

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

    def upload_image
      image = params[:cocoroco][:attached_image_url]&.tempfile
      return unless image
      s3 = Aws::S3::Resource.new(region: 'eu-west-3')
      key = "uploads/#{SecureRandom.hex(3)}_#{@cocoroco.id}"
      obj = s3.bucket(SECRETS['aws_bucket']).object(key)

      obj.upload_file(image.path)
      @cocoroco.attached_image_url = obj.public_url
    end

    def cocoroco_params
      params.require(:cocoroco).permit(:content, :author)
    end
  end
end
