class TumblesController < ApplicationController
  def index
    @tumbles = Tumble.get_by_types(params).get_by_tags(params).get_by_users(params).order('date DESC').page(params['page'] || 1).per(2)

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
      #@tumbles = Tumble.where('title LIKE ?', "%#{@query}%").get_by_types(params).get_by_tags(params).order('date DESC')
      #@@tumbles = Tumble.where('title LIKE ?', "%#{@query}%").order('date DESC')
      @tumbles = Tumble.find_with_index(@query)
    end

    respond_to do |format|
      format.html
      format.js
    end
  end
end