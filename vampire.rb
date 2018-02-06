class Vampire
  @@vampire_list = []

  def initialize(name, age)
    @name = name
    @age = age
    @in_coffin = true
    @drank_blood_today = false
  end

  def self.create(name, age)
    new_vampire = Vampire.new(name, age)
    @@vampire_list << new_vampire
    return new_vampire
  end

  def drink_blood
    @drank_blood_today = true
  end

  def self.sunrise
    @@vampire_list.delete_if {|vampire_x| vampire_x.in_coffin == false }
    @@vampire_list.delete_if {|vampire_x| vampire_x.drank_blood_today == false }
  end

  def self.sunset
    @@vampire_list.each do |vampire_x|
      vampire_x.go_out
    end
  end

  def go_home
    @in_coffin = true
  end

  def go_out
    @in_coffin = false
    @drank_blood_today = false
  end

  def in_coffin
    return @in_coffin
  end

  def drank_blood_today
    return @drank_blood_today
  end

  def self.all
    return @@vampire_list
  end

end

puts Vampire.all.inspect
vampire1 = Vampire.create('John', 35)
vampire2 = Vampire.create('Peter', 56)
vampire3 = Vampire.create('Tom', 26)
vampire4 = Vampire.create('Bob', 77)
puts Vampire.all.inspect

puts Vampire.sunset.inspect

puts vampire1.go_home.inspect

puts vampire2.drink_blood.inspect
puts vampire2.go_home.inspect

puts vampire3.drink_blood.inspect

puts Vampire.all.inspect

puts Vampire.sunrise.inspect
