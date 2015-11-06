require_relative "Enemy.rb"

class EnemyGenerator
  attr_accessor :target

  def initialize(target)
    @target = target
  end

  def generate
    return wave0
  end

  def wave0
    enemy = Enemy.new
    enemy.x = 50
    enemy.y = 50
    enemy.target = @target
    enemy.speed = 1
    
    return [enemy]
  end

end
