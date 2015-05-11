# Defines basic structure of a query
class Query
  delegate :to_sql, :inspect, to: :scope

private

  def scope
    raise NotImplementedError, 'Subclass must define scope.'
  end
end
