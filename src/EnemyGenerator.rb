require_relative "Enemy.rb"

class EnemyGenerator
  attr_accessor :target
  attr_accessor :waveCount

  def initialize(map, target)
    @map = map
    @target = target
    @waveCount = 0

    @mapW = @map.width - (@map.borderWidth * 2)
    @mapH = @map.height - (@map.borderWidth * 2)
    puffer = 4
    @spriteSize = (0.5 * (26)) + puffer
  end

  def nextWave
      @waveCount += 1
      return waveN(@waveCount)
  end

  def waveN(n)
      enemies = []

      (n * 5).times do |i|
        enemy = Enemy.new
        enemy.target = @target
        enemy.speed = rand(150) * 0.01 + 0.1

        randomSpawn(enemy)
        enemies << enemy
      end

      return enemies
  end

  def randomSpawn(enemy)
      area = rand(4)

      if (area==0)
        enemy.x = @map.borderWidth + @spriteSize + rand(@mapW - (@spriteSize * 2))
        enemy.y = @map.borderWidth + @spriteSize + rand(50)
      end

      if (area==1)
        enemy.x = @map.borderWidth + @spriteSize + rand(50)
        enemy.y = @map.borderWidth + @spriteSize + rand(@mapH - (@spriteSize * 2))
      end

      if (area==2)
        enemy.x = @map.borderWidth + @spriteSize + rand(@mapW - (@spriteSize * 2))
        enemy.y = @map.borderWidth - @spriteSize + @mapH - 50 + rand(50)
      end

      if (area==3)
        enemy.x = @map.borderWidth - @spriteSize + @mapW - 50 + rand(50)
        enemy.y = @map.borderWidth + @spriteSize + rand(@mapH - (@spriteSize * 2))
      end
  end

end
