require_relative 'types'
require_relative 'company'

class Carriage
  include Company

  attr_reader :type

  def initialize(type)
    @type = type
  end  
end