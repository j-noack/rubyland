
class EnemyAI
  attr_accessor :enemy

  def initialize(enemy)
    @enemy = enemy
  end

  def update
    target = @enemy.target

    @enemy.x += enemy.speed * ratio
    @enemy.y += enemy.speed / ratio
  end

  def ratio
    return (@enemy.x - target.x) / (@enemy.y - target.y)
  end
end
