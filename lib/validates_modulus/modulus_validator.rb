# frozen_string_literal: true

require "active_model"
require "validates_modulus/mod11"

class ModulusValidator < ActiveModel::EachValidator
  MODULUS = {
    mod11: ValidatesModulus::Mod11
  }.freeze

  def invalid?(value)
    mode_class = MODULUS[options[:with]]
    raise ArgumentError, "Unknown or missing modulus name: '#{options[:with]}'" unless mode_class
    !mode_class.new(value).valid?
  end

  def validate_each(record, attribute, value)
    if invalid?(value)
      record.errors.add attribute, (options[:message] || :bad_checksum)
    end
  end
end
