module DogMixin
  class << self
    def included(base)
      base.include InstanceMethods
      base.extend ClassMethods
    end
  end

  module ClassMethods
    def assign(*names)
      # @dogs is bound to the EACH DogOwner subclass
      @dog_names = names
    end

    def dog_names
      # @dogs is bound to the EACH DogOwner subclass
      @dog_names
    end

    def inst
      @inst ||= 0
    end

    def inst=(inst)
      @inst = inst
    end
  end

  module InstanceMethods
    protected
    def register_instance
      self.class.inst += 1
    end
  end
end

class Owner
  include DogMixin

  def initialize
    register_instance()
  end
end

class Nerd < Owner
  assign :r2d2, :posix
end

class Emo < Owner
  assign :bill, :tom
end

class Hater < Owner
end

p Nerd.inst
p Emo.inst

n1 = Nerd.new()
n2 = Nerd.new()
n3 = Nerd.new()

e1 = Emo.new()
e2 = Emo.new()

p Nerd.inst
p Emo.inst


# p Nerd.dog_names

# p Emo.dog_names

# p Hater.dog_names