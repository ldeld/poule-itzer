class CocorocosController < ApplicationController
  def new
    @cocoroco = Cocoroco.new
  end

  def create
    @cocoroco = Cocoroco.new(cocoroco_params)
    if @cocoroco.save
      flash[:notice] = 'Succesfully created'
      redirect_to new_cocoroco_path
    else
      flash[:alert] = @cocoroco.errors.full_messages.first
      render :new
    end
  end

  private

  def cocoroco_params
    params.require(:cocoroco).permit(:author, :content, :profile_image_url, :attached_image_url)
  end
end
