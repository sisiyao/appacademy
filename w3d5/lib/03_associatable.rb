require_relative '02_searchable'
require 'active_support/inflector'

# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    @class_name.constantize
  end

  def table_name
    model_class.table_name
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    defaults = {
      foreign_key: "#{name}_id".to_sym,
      primary_key: :id,
      class_name: name.to_s.camelcase
    }.merge(options)

    @foreign_key = defaults[:foreign_key]
    @primary_key = defaults[:primary_key]
    @class_name = defaults[:class_name]
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    defaults = {
      foreign_key: "#{self_class_name.downcase}_id".to_sym,
      primary_key: :id,
      class_name: name.to_s.downcase.singularize.camelcase
    }.merge(options)

    @foreign_key = defaults[:foreign_key]
    @primary_key = defaults[:primary_key]
    @class_name = defaults[:class_name]
  end
end

module Associatable
  # Phase IIIb
  def belongs_to(name, options = {})
    p self.name
    options = BelongsToOptions.new(name, options)

    define_method(name) do
      options.model_class
        .where(options.primary_key => send(options.foreign_key))
        .first
    end
  end

  def has_many(name, options = {})
    p "hello"
    options = HasManyOptions.new(name, self.name, options)

    define_method(name) do
      options.model_class
        .where(options.foreign_key => send(options.primary_key))
    end
  end

  def assoc_options
    # Wait to implement this in Phase IVa. Modify `belongs_to`, too.
  end
end

class SQLObject
  # Mixin Associatable here...
  extend Associatable
end
