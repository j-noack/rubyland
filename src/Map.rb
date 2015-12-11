require_relative 'Drawable.rb'
require_relative 'Player.rb'
require_relative 'EnemyGenerator.rb'
require_relative 'Crosshair.rb'
require_relative 'CollisionManager.rb'

class Map < Drawable
    attr_accessor :player
    attr_accessor :enemies
    attr_accessor :borderWidth
    attr_accessor :projectiles
    attr_accessor :enemyGenerator

    def initialize(width, height, borderWidth, highscore)
        super()

        @width = width
        @height = height
        @borderWidth = borderWidth
        @highscore = highscore
        @player = Player.new
        @player.x = width / 2
        @player.y = height / 2

        @enemyGenerator = EnemyGenerator.new(self, @player)
        @enemies = []
        @projectiles = []

        @collisionManager = CollisionManager.new(self)
        @backgroundImage = Gosu::Image.new('assets/Rubyland.bmp')
    end

    def getProjectiles(being)
        projectiles = being.getProjectiles
        @projectiles.concat(projectiles)
    end

    def update(mouse_x, mouse_y)
        @player.update(mouse_x, mouse_y, x, y)
        getProjectiles(@player)

        @player.moveX if @collisionManager.canPlayerMoveX?
        @player.moveY if @collisionManager.canPlayerMoveY?

        @enemies.each do |enemy|
            enemy.update
            enemy.moveX if @collisionManager.canEnemyMoveX?(enemy)
            enemy.moveY if @collisionManager.canEnemyMoveY?(enemy)
            getProjectiles(enemy)
        end

        @projectiles.each do |projectile|
            projectile.update
            @collisionManager.checkProjectileCollisionsWithBeing(projectile)

            if @collisionManager.canProjectileFly?(projectile)
                projectile.fly
            else
                projectile.duration = 0
            end
        end

        @projectiles.delete_if do |projectile|
            projectile.duration <= 0 || projectile.durability <= 0
        end

        # Highscore and dead enemies
        dead_enemies = @enemies.select(&:dead?)

        dead_enemies.each do |enemy|
            @highscore.score += enemy.score
            @enemies.delete(enemy)
        end

        if @enemies.empty?
            @highscore.score += @enemyGenerator.waveCount * 20
            @enemies.concat(@enemyGenerator.nextWave)
        end

        if Gosu.button_down?(Gosu::KbDelete)
            @enemies.each { |enemy| enemy.hp = 0 }
        end
    end

    def draw(font)
        @backgroundImage.draw(@x, @y, @z)
        @enemies.each do |enemy|
            enemy.draw(x, y)
        end

        @player.draw(x, y)

        @projectiles.each do |projectile|
            projectile.draw(x, y)
        end

        if @player.dead?
            width = font.text_width('GAME OVER')
            font.draw('GAME OVER', (@width / 2) - (width / 2), @height / 2, 999)
        end
    end

    def waveCount
        @enemyGenerator.waveCount
    end
end
