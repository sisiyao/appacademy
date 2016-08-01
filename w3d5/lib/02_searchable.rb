require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable
  def where(params)
    where_clause = []
    values = []
    params.each do |attr_name, attr_value|
      where_clause << "#{attr_name} = ?"
      values << attr_value
    end

    results = DBConnection.execute(<<-SQL, *values)
      SELECT *
      FROM #{self.table_name}
      WHERE #{where_clause.join(" AND ")}
    SQL

    results.map { |result| self.new(result) }
  end
end

class SQLObject
  # Mixin Searchable here...
  extend Searchable
end
