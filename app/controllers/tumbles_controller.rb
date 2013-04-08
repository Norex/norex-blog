class TumblesController < ApplicationController
  def index
    @tumbles = Tumble.get_by_types(params).get_by_tags(params).order('date DESC')
    require 'pp'
    pp params
    pp @tumbles

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @tumble = Tumble.find(params[:id])
  end

  def search
    @query = params[:query].downcase

    unless @query.blank?
      @tumbles = Tumble.where('title LIKE ?', "%#{@query}%")
    end
  end
end