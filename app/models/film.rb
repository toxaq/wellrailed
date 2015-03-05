class Film < ActiveRecord::Base
  belongs_to :language

  class << self
    def fast_json
      filter_sql = select('id').to_sql
      sql = build_sql(filter_sql)
      Oj.load(connection.select_value(sql))
    end

    def build_sql(id_sql)
      "
with our_languages as (
    select id, row_to_json(lj) pgjson
    FROM ( select id, name from languages) lj
),
our_films as (
    SELECT id, row_to_json(fj) pgjson
    FROM (
        select films.id, title, release_year, our_languages.pgjson \"language\"
        from films
        left join our_languages
        on films.language_id = our_languages.id
    ) fj
)
select json_agg(our_films.pgjson)
from our_films
where id in (#{id_sql})"
      #ActiveRecord::Base.send(:sanitize_sql_array, [sql, ids])
    end
  end
end