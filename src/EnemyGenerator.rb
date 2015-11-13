require_relative "Enemy.rb"

class EnemyGenerator
  attr_accessor :target

  def initialize(map, target)
    @map = map
    @target = target
  end

  def generate
    return wave1
  end

  def wave0
    enemy = Enemy.new
    enemy.x = 50
    enemy.y = 50
    enemy.target = @target
    enemy.speed = 1

    enemy2 = Enemy.new
    enemy2.x = 800
    enemy2.y = 500
    enemy2.target = @target
    enemy2.speed = 1.5

    return [enemy, enemy2]
  end

  def wave1
    enemies = []

    mapW = @map.width
    mapH = @map.height

    100.times do |i|
      enemy = Enemy.new
      enemy.x = rand(mapW)
      enemy.y = rand(mapH)
      enemy.target = @target
      enemy.speed = rand(150) * 0.01 + 0.1

      enemies << enemy
    end

    return enemies
  end

end
