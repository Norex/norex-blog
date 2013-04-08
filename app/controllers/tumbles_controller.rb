class TumblesController < ApplicationController
  def index
    @tumbles = Tumble.get_by_types(params).get_by_tags(params).get_by_users(params).order('date DESC')

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
      @tumbles = Tumble.where('title LIKE ?', "%#{@query}%").order('date DESC')
    end

    # require 'pp'
    # tag_list = []
    
    # @tag_list = @tumbles.map { |t| t.tags }.flatten.uniq
    # @type_list = @tumbles.map { |t| t.content_type }.uniq
    
    # @tag_list.each do |t| 
    #   puts t.count
    # end
    # pp @tag_list
    # pp @type_list

    respond_to do |format|
      format.html
      format.js
    end
  end
end