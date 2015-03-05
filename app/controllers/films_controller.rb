class FilmsController < ApplicationController
  def index
    @films = Film.includes(:language).all
    #render json: Film.all.fast_json
  end
end