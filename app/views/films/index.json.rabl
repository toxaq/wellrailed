collection @films

attributes :id, :title, :description, :release_year

child(:language => :language){attributes :id, :name}