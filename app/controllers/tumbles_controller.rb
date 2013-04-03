class TumblesController < ApplicationController
  def index
    @tumbles = Tumble.order('date DESC')
  end
end
