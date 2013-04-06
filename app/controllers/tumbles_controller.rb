class TumblesController < ApplicationController
  def index
    #puts Tumble.tag_counts
    #uts params
    # if params[:tags]
      #@tumbles = Tumble.tagged_with(params[:tag]).order('date DESC')
      @tumbles = Tumble.get_by_tags(params)
      #puts @tumbles
    # else
    #   @tumbles = Tumble.order('date DESC')
    # end
  end

  def show
    @tumble = Tumble.where(id: params[:id]).first
  end

  def search
    @query = params[:query].downcase

    unless @query.blank?
      @tumbles = Tumble.where('title LIKE ?', "%#{@query}%")
    end
  end

  private
  # def get_by_tags
  #   tags = params[:tags] || nil
  #   if tags.empty?
  #     # Tumbles.all
  #     # Display no posts.
  #   elsif tags.nil?
  #     # Display all posts
  #   else
  #     Tumble.tagged_with(tags)
  #   end
  # end
end
