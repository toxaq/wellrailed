class Film < ActiveRecord::Base
  belongs_to :language

  class << self
    def fast_json
      filter_sql = select('id').to_sql
      sql = build_sql(filter_sql)
      Oj.load(connection.select_value(sql))
    end

    def build_sql(id_sql)
      sql = "
with our_films as (
    SELECT id, row_to_json(fj) pgjson
    FROM (
         select id, title, release_year
    FROM films
    ) fj
)

select json_agg(pgjson)
from our_films
where id in (#{id_sql})"
      #ActiveRecord::Base.send(:sanitize_sql_array, [sql, ids])
    end
  end
end