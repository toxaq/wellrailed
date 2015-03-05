class FilmsController < ApplicationController
  def index
    @films = Film.includes(:language).all
    #render json: Film.includes(:language).all.fast_json
  end
end