class CorrectEmailFormatValidator < ActiveModel::EachValidator
  def validate_each(record,attribute,value)
    record.errors[attribute] << "Email is not valid." unless value.include? "@"
  end
end
