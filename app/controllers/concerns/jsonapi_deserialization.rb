module JSONAPIDeserialization
  extend ActiveSupport::Concern

  def jsonapi_parse!(options = {})
    ActiveModelSerializers::Deserialization.jsonapi_parse!(params, options)
  end
end
