
class EnemyAI
  attr_accessor :enemy

  def initialize(enemy)
    @enemy = enemy
  end

  def update
    @enemy.x += @enemy.speed * ratioX
    @enemy.y += @enemy.speed * ratioY
  end

  def ratioX
    target = @enemy.target
    deltaX = @enemy.x - target.x
    deltaY = @enemy.y - target.y
    if (deltaY != 0)
      return deltaX / deltaY
    else
      return deltaX
    end
  end

  def ratioY
    target = @enemy.target
    deltaX = @enemy.x - target.x
    deltaY = @enemy.y - target.y
    if (deltaX != 0)
      return deltaY / deltaX
    else
      return deltaY
    end
  end

end
