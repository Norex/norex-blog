class TumblesController < ApplicationController
  def index
    if params[:tag]
      @tumbles = Tumble.tagged_with(params[:tag]).order('date DESC')
    else
      @tumbles = Tumble.order('date DESC')
    end
  end

  def show
    @tumble = Tumble.where(id: params[:id]).first
  end
end
