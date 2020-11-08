module InstanceCounter
  def self.included(base)    
    base.extend ClassMethods  
    base.include InstanceMethods  
  end

  module ClassMethods
    def instances
      @instances ||= 0
    end

    def instances=(instance)
      @instances = instance
    end
  end

  module InstanceMethods
    private
      def register_instance
        self.class.instances += 1
      end
  end
end

class Z
  include InstanceCounter
  def initialize
    register_instance()
  end
end

class A < Z; end
class C < Z; end

class B
  include InstanceCounter
  def initialize
    register_instance()
  end
end

p A.instances
p B.instances
p C.instances
p Z.instances

Z.new
Z.new

C.new

A.new
A.new
A.new

B.new
B.new
B.new
B.new

p A.instances # 3
p B.instances # 4
p C.instances # 1
p Z.instances # 2

