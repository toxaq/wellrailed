class ActorsController < ApplicationController
  def index
    @actors = Actor.includes([:film_actors => :film]).all
    #render json: Actor.all.fast_json
  end
end