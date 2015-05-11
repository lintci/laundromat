# The result of linting a group of files
class Linting
  include Virtus.value_object

  values do
    attribute :task_id, Integer
    attribute :clean, Boolean
  end
end
