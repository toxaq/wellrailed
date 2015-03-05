class ActorsController < ApplicationController
  def index
    @actors = Actor.includes([:film_actors => :film]).all
    #render json: Actor.includes(:films).all.fast_json
  end
end