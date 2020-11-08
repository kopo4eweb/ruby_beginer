require_relative 'types'

class Carriage
  attr_reader :type

  def initialize(type)
    @type = type
  end  
end