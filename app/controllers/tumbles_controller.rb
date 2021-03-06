class TumblesController < ApplicationController
  def index
    # @tumbles = Tumble.get_by_types(params).get_by_tags(params).get_by_users(params).order('date DESC').page(params['page'] || 1).per(2)
    @tumbles = Tumble.order('date DESC').page(params['page'] || 1).per(5)

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @tumble = Tumble.find(params[:id])
    @next_tumble = Tumble.where('date < ?', @tumble.date).order('date DESC').first
    @prev_tumble = Tumble.where('date > ?', @tumble.date).order('date ASC').first
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

  def recent
    tumble = Tumble.where('content_type != "photo"').order('date DESC').first
    result = { title: tumble.title, content: tumble.content, url: tumble_url(tumble) }

    respond_to do |format|
      format.html { render json: result }
      format.json { render json: result }
    end
  end
end