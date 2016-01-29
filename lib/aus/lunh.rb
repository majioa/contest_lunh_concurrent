module Aus
  module Lunh
    def self.is_number_valid? number
      ::Luhn.valid?(number)
    end

    def self.encode number
      "#{number}#{::Luhn.control_digit(number)}"
    end
  end
end
