# This class was made to help test class agnostic engine functionality that
# requires model interfaces to work.
#
# An example would be tests for polymorphic associations:
#   foo = Udongo::BogusModel.new(id: 37, description: 'foobar', hidden?: false)
#   create(:search_index, searchable: foo, locale: 'nl')
class Udongo::BogusModel < OpenStruct
  attr_reader :id

  def self.base_class
    self.class
  end

  def self.primary_key
    :id
  end

  def _read_attribute(attribute)
    nil
  end

  def id
    @id = rand(1..1000) unless @id
    @id
  end

  def destroyed?
    false
  end

  def new_record?
    false
  end
end
