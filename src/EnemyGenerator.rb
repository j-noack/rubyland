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

  def wave1
    enemies = []

    mapW = @map.width - (@map.borderWidth * 2)
    mapH = @map.height - (@map.borderWidth * 2)
    puffer = 4

    50.times do |i|
      enemy = Enemy.new
      spriteSize = (0.5 * (enemy.width+1))+puffer
      area = rand(4)
      if (area==0)
        enemy.x = @map.borderWidth + spriteSize + rand(mapW - (spriteSize * 2))
        enemy.y = @map.borderWidth + spriteSize + rand(50)
      end
      if (area==1)
        enemy.x = @map.borderWidth + spriteSize + rand(50)
        enemy.y = @map.borderWidth + spriteSize + rand(mapH - (spriteSize * 2))
      end
      if (area==2)
        enemy.x = @map.borderWidth + spriteSize + rand(mapW - (spriteSize * 2))
        enemy.y = @map.borderWidth - spriteSize + mapH - 50 + rand(50)
      end
      if (area==3)
        enemy.x = @map.borderWidth - spriteSize + mapW - 50 + rand(50)
        enemy.y = @map.borderWidth + spriteSize + rand(mapH - (spriteSize * 2))
      end

      enemy.target = @target
      enemy.speed = rand(150) * 0.01 + 0.1

      enemies << enemy
    end

    return enemies
  end

end
