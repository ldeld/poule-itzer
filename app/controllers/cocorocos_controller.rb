class CocorocosController < ApplicationController
  def new
    @cocoroco = Cocoroco.new
  end

  def create
    if @cocoroco.save
      redirect_to new_cocoroco_page, notice: 'Succesfully created'
    else
      render :new
    end
  end

  def show
  end
end
