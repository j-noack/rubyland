require_relative 'Enemy.rb'

class EnemyGenerator
    attr_accessor :target
    attr_accessor :waveCount

    @@ENEMIES = []
    @@ENEMY_TYPES = [ChargerEnemy, DefaultEnemy, CirclerEnemy, BlobberEnemy]

    def initialize(map, target)
        @map = map
        @target = target
        @waveCount = 0

        @mapW = @map.width - (@map.borderWidth * 2)
        @mapH = @map.height - (@map.borderWidth * 2)
        puffer = 4
        @spriteSize = (0.5 * (26)) + puffer

        preSpawn
    end

    def preSpawn
        @@ENEMY_TYPES.each do |type|
            spawn(type, 125)
        end
    end

    def count
        @@ENEMIES.count {|enemy| enemy.enabled && !enemy.dead?}
    end

    def nextWave
        @waveCount += 1

        if (@waveCount == 1)
            spawnFirstBoss
        else
            waveN(@waveCount)
        end
    end

    def waveN(n)
        enemies = []
        nextEnemiesCount = n * 3
        diff = nextEnemiesCount - @@ENEMIES.length
        # Pre-calculate enemy types
        nextTypes = []
        nextEnemiesCount.times do |i|
            nextTypes << @@ENEMY_TYPES.sample
        end

        if diff > 0
            # Spawn always random type
            puts "Allocating #{diff} new enemies."
            diff.times do |i|
                spawn(nextTypes.sample)
            end
        end

        nextEnemiesCount.times do |i|
            pooledEnemy = @@ENEMIES.find do |enemy|
                enemy.is_a?(nextTypes[i]) && !enemies.include?(enemy)
            end

            if pooledEnemy.nil?
                spawn(nextTypes[i])
                pooledEnemy = @@ENEMIES.last
            end

            randomize(pooledEnemy)
            enemies << pooledEnemy
        end

        enemies
    end

    def spawn(enemyClass, count = 1)
        enemies = Array.new(count) { enemyClass.new }
        @@ENEMIES.concat(enemies)
    end

    # TODO: check ai type and create different set of random values
    def randomize(enemy)
        enemy.randomize(@target)
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

    def customSpawn(type, x, y)
        enemy = type.new
        enemy.randomize(@target)
        enemy.x = x
        enemy.y = y
        enemy.ai.enemyGenerator = self

        @map.customSpawn(enemy)
    end

    def spawnFirstBoss
        customSpawn(BossEnemy, 200, 200)
    end
end
