require_relative "Enemy.rb"

class EnemyGenerator

  def initialize
  end

  def generate
    return wave0
  end

  def wave0
    enemy = Enemy.new
    enemy.x = 50
    enemy.y = 50

    return [enemy]
  end

end
