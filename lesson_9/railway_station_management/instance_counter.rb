# frozen_string_literal: true

# couter for all classes
module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  # methods for class
  module ClassMethods
    def instances
      @instances ||= 0
    end

    def instances=(instance)
      @instances = instance
    end
  end

  # methods for instance
  module InstanceMethods
    protected

    def register_instance
      self.class.instances += 1
    end
  end
end
