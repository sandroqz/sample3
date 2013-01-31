class SingleWordValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << (options[:message] || "should be one word only") unless value =~ /^[a-zA-Z0-9]+$/
  end
end
