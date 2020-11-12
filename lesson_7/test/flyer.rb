class Flyer
  attr_reader :name, :email, :miles_flown

  def initialize(name, email, miles_flown)
    @name = name
    @email = email
    @miles_flown = miles_flown
  end

  def to_s
    "#{name} (#{email}): #{miles_flown}"
  end
end

flyer_arr = []

1.upto(5) do |i| 
  flyer_arr << Flyer.new("User #{i}", "user#{i}@mail.com", 1000 * i)
  puts flyer_arr.last
end
