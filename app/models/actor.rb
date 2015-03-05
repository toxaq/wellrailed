class Actor < ActiveRecord::Base
  has_many :film_actors
  has_many :films, through: :film_actors
end