# frozen_string_literal: true

# class handler custom error
class Error
  class << self
    def show_message(message)
      puts "! Ошибка: #{message}"
    end
  end
end
