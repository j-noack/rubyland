require_relative 'Enemy.rb'
require 'benchmark'

class EnemyGenerator
    attr_accessor :target
    attr_accessor :waveCount

    @@ENEMIES = []

    def initialize(map, target)
        @map = map
        @target = target
        @waveCount = 0

        @mapW = @map.width - (@map.borderWidth * 2)
        @mapH = @map.height - (@map.borderWidth * 2)
        puffer = 4
        @spriteSize = (0.5 * (26)) + puffer

        # Pre-spawn 1000 enemies
    #    spawn(Enemy, 1000)
    end

    def count
        @@ENEMIES.count {|enemy| enemy.enabled && !enemy.dead?}
    end

    def nextWave
        @waveCount += 1
        waveN(@waveCount)
    end

    def waveddN(n)
        spawn(CirclerEnemy, 1)
        @@ENEMIES.each do |e|
            randomize(e)
        end

    end

    def waveN(n)
        enemies = []
        nextEnemiesCount = n * 5
        diff = nextEnemiesCount - @@ENEMIES.length

        if diff > 0
            puts "Allocating #{diff} new enemies."
            spawn(Enemy, diff)
        end

        nextEnemiesCount.times do |i|
            enemy = @@ENEMIES[i]
            randomize(enemy)
            enemies << enemy
        end

        enemies
    end

    def spawn(enemyClass, n)
        n.times do |_i|
            enemy = enemyClass.new
            @@ENEMIES << enemy
        end
    end

    # TODO: check ai type and create different set of random values
    def randomize(enemy)
        enemy.resetHp
        enemy.target = @target
        enemy.speed = rand(150) * 0.01 + 0.1
        enemy.enabled = true

        randomizePosition(enemy)
    end

    def randomizePosition(enemy)
        area = rand(4)

        if area == 0
            enemy.x = @map.borderWidth + @spriteSize + rand(@mapW - (@spriteSize * 2))
            enemy.y = @map.borderWidth + @spriteSize + rand(50)
        end

        if area == 1
            enemy.x = @map.borderWidth + @spriteSize + rand(50)
            enemy.y = @map.borderWidth + @spriteSize + rand(@mapH - (@spriteSize * 2))
        end

        if area == 2
            enemy.x = @map.borderWidth + @spriteSize + rand(@mapW - (@spriteSize * 2))
            enemy.y = @map.borderWidth - @spriteSize + @mapH - 50 + rand(50)
        end

        if area == 3
            enemy.x = @map.borderWidth - @spriteSize + @mapW - 50 + rand(50)
            enemy.y = @map.borderWidth + @spriteSize + rand(@mapH - (@spriteSize * 2))
        end
    end
end
