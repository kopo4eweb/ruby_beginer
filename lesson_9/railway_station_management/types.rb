# frozen_string_literal: true

# general types for set train ans carriage
class Type
  def self.classes
    [Cargo, Passenger]
  end
end

# rubocop:disable Lint/EmptyClass
# type
class Cargo; end

# type
class Passenger; end
# rubocop:enable Lint/EmptyClass
