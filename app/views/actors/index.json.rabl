collection @actors

attributes :id, :first_name, :last_name
child(:films => :films) do
  attributes :id, :title
end