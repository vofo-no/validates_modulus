# frozen_string_literal: true

module ValidatesModulus
  # Class for validating numbers with modulus 11 control digit.
  #
  # Example usage:
  #
  #     number = Mod11.new(12345)
  #     number.valid? # => false
  #
  #     number = Mod11.new('000')
  #     number.valid? # => true
  class Mod11
    WEIGHT = [2, 3, 4, 5, 6, 7].freeze

    # Non-digts are stripped during initialization.
    def initialize(value)
      @value = value.to_s.gsub(/\D/, "")
    end

    # Checks whether the given nuber has the right control digit.
    def valid?
      @value.length > 1 && @value.chars.last.to_i == check_digit
    end

    private

      # Calclulates the checksum according to the modulus 11 algorithm.
      def checksum
        @value.reverse.chars.drop(1).map.with_index do |number, index|
          number.to_i * WEIGHT[index % 6]
        end.inject(:+)
      end

      # Calclulates the modulus 11 control digit.
      def check_digit
        remainder = 11 - (checksum % 11)

        case remainder
        when 10 then nil
        when 11 then 0
        else remainder
        end
      end
  end
end