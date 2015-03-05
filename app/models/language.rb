class Language < ActiveRecord::Base
  has_many :films, inverse_of: :language
end