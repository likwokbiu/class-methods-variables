class Zombie
  @@horde = []
  @@plague_level = 10
  @@max_speed = 5
  @@max_strength = 8
  @@default_speed = 1
  @@default_strength = 3

  def initialize(speed, strength)
    if speed > @@max_speed
      @speed = @@default_speed
    else
      @speed = speed
    end
    if strength > @@max_strength
      @strength = @@default_strength
    else
      @strength = strength
    end
  end

  def encounter
    if outrun_zombie?
      return "You escaped!"
    elsif !survive_attack?
      return "You died!"
    else
      new_zombie = Zombie.new(Random.rand(@@max_speed + 1), Random.rand(@@max_strength + 1))
      @@horde << new_zombie
      return "You are now a zombie!"
    end
  end

  def outrun_zombie?
    if Random.rand(@@max_speed + 1) > @speed
      return true
    else
      return false
    end
  end

  def survive_attack?
    if Random.rand(@@max_strength + 1) > @strength
      return true
    else
      return false
    end
  end

  def self.all
    return @@horde
  end

  def self.new_day
    Zombie.some_die_off
    Zombie.spawn
    Zombie.increase_plague_level
  end

  def self.some_die_off
    Random.rand(11).times do
      @@horde.delete_at(-1)
    end
  end

  def self.spawn
    Random.rand(@@plague_level + 1).times do
      new_zombie = Zombie.new(Random.rand(@@max_speed + 1), Random.rand(@@max_strength + 1))
      @@horde << new_zombie
    end
  end

  def self.increase_plague_level
    @@plague_level += Random.rand(3)
  end

end


puts Zombie.all.inspect # []
Zombie.new_day
puts Zombie.all.inspect # [#<Zombie:0x005626ecc5ebd0 @speed=4, @strength=0>, #<Zombie:0x005626ecc5eba8 @speed=0, @strength=4>, #<Zombie:0x005626ecc5eb80 @speed=4, @strength=4>]
zombie1 = Zombie.all[0]
zombie2 = Zombie.all[1]
zombie3 = Zombie.all[2]
puts zombie1.encounter # You are now a zombie
puts zombie2.encounter # You died
puts zombie3.encounter # You died
Zombie.new_day
puts Zombie.all.inspect # [#<Zombie:0x005626ecc5e1f8 @speed=0, @strength=0>, #<Zombie:0x005626ecc5e180 @speed=3, @strength=3>, #<Zombie:0x005626ecc5e158 @speed=1, @strength=2>, #<Zombie:0x005626ecc5e090 @speed=0, @strength=4>]
zombie1 = Zombie.all[0]
zombie2 = Zombie.all[1]
zombie3 = Zombie.all[2]
puts zombie1.encounter # You got away
puts zombie2.encounter # You are now a zombie
puts zombie3.encounter # You died
