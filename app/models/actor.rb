class Actor < ActiveRecord::Base
  has_many :film_actors
  has_many :films, through: :film_actors

  class << self
    def fast_json
      filter_sql = select('id').to_sql
      sql = build_sql(filter_sql)
      Oj.load(connection.select_value(sql))
    end
    def build_sql(id_sql)
      "with our_languages as (
	select id, row_to_json(lj) pgjson
	FROM ( select id, name from languages) lj
),
our_films as (
	SELECT id, row_to_json(fj) pgjson
	FROM (
		select films.id, title, release_year--, our_languages.pgjson \"language\"
		from films
		/*left join our_languages
		on films.language_id = our_languages.id*/
	) fj
),
our_actor_films as (
	select film_actors.actor_id, json_agg(our_films.pgjson) pgjson from our_films, film_actors
	where our_films.id = film_actors.film_id
	group by film_actors.actor_id
),
our_actors as (
	select id, row_to_json(sq) pgjson
	from (
	select id, first_name, last_name, pgjson films
	from actors, our_actor_films
	where actors.id = our_actor_films.actor_id
	) sq
)

select json_agg(our_actors.pgjson)
from our_actors
where id in (#{id_sql})"
    end
  end
end