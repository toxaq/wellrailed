class ActorsController < ApplicationController
  def index
    @actors = Actor.includes([:film_actors => :film]).all
    #@actors = Actor.includes(:films).all
  end
end