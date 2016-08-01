require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    query = <<-SQL
      SELECT *
      FROM #{self.table_name}
    SQL
    @col ||= DBConnection.execute2(query).first.map(&:to_sym)
  end

  def self.finalize!
    columns.each do |col|
      define_method(col) do
        self.attributes[col]
      end

      define_method("#{col}=") do |val|
        self.attributes[col] = val
      end
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name ||= "#{self}".tableize
  end

  def self.all
    results = DBConnection.execute(<<-SQL)
      SELECT *
      FROM #{self.table_name}
    SQL

    self.parse_all(results)
  end

  def self.parse_all(results)
    obj = []
    results.each do |result|
      obj << self.new(result)
    end
    obj
  end

  def self.find(id)
    # self.all.find { |obj| obj.attributes[:id] == id }
    result = DBConnection.execute(<<-SQL, id)
      SELECT *
      FROM #{self.table_name}
      WHERE id = ?
    SQL

    result.empty? ? nil : self.new(result.first)
  end

  def initialize(params = {})
    params.each do |attr_name, attr_value|
      raise "unknown attribute '#{attr_name}'" unless self.class.columns.include?(attr_name.to_sym)

      send("#{attr_name}=", attr_value)
    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    self.class.columns.map { |col_name| self.send(col_name) }
  end

  def insert
    cols = self.class.columns.dup
    cols.delete(:id)
    col_names = cols.join(", ")

    qms = []
    num_qms = cols.length.times { qms << "?"}
    qms = qms.join(", ")

    values = attribute_values.dup
    values.delete(nil)

    DBConnection.execute(<<-SQL, *values)
      INSERT INTO #{self.class.table_name} (#{col_names})
      VALUES (#{qms})
    SQL

    self.id = DBConnection.last_insert_row_id
  end

  def update
    cols = self.class.columns.dup
    cols.delete(:id)
    set = cols.map { |col| "#{col} = ?"}.join(", ")

    values = attribute_values.dup
    id_val = self.id
    values.delete(id_val)
    values << id_val

    DBConnection.execute(<<-SQL, *values)
      UPDATE #{self.class.table_name}
      SET #{set}
      WHERE id = ?
    SQL
  end

  def save
    self.id.nil? ? insert : update
  end
end
