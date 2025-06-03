# frozen_string_literal: true

# Method to check validity of a Siret number
# exp 41315728000046 or 97808713800019

class SiretValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if valid_siret?(value)

    record.errors.add attribute, (options[:message] || "invalide")
  end

  def valid_siret?(number)
    number = number.to_s
    return false unless number.match?(/\A\d{14}\z/)

    valid_luhn?(number)
  end

  def valid_luhn?(number)
    return false unless number

    s = []
    number.reverse.chars.each_slice(2) do |odd, even|
      s << odd.to_i
      double = even.to_i * 2
      double -= 9 if double >= 10
      s << double
    end
    (s.sum % 10).zero?
  end
end
