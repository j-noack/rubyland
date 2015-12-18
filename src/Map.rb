require_relative 'Drawable.rb'
require_relative 'Player.rb'
require_relative 'EnemyGenerator.rb'
require_relative 'Crosshair.rb'
require_relative 'CollisionManager.rb'
require_relative 'Drop.rb'

class Map < Drawable
    attr_accessor :player
    attr_accessor :enemies
	attr_accessor :drops
    attr_accessor :projectiles
    attr_accessor :borderWidth
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
		@drops = []

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

		@drops.each do |drop|
			drop.update
			if (drop.duration < 1)
				@drops.delete(drop)
			end
		end

        if @collisionManager.canPlayerMove?
            @player.moveX if @collisionManager.canPlayerMoveBorderX?
            @player.moveY if @collisionManager.canPlayerMoveBorderY?
        end

		@collisionManager.checkPlayerCollisionWithDrops

        @enemies.each do |enemy|
            enemy.update
            if @collisionManager.canEnemyMove?(enemy)
                enemy.moveX if @collisionManager.canEnemyMoveBorderX?(enemy)
                enemy.moveY if @collisionManager.canEnemyMoveBorderY?(enemy)
            end
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
			if rand(15) == 1
				weapon_number = rand(3)
				weapon = nil
				if weapon_number == 0
					weapon = SMG.new(@player)
				end
				if weapon_number == 1
					weapon = Shotgun.new(@player)
				end
				if weapon_number == 2
					weapon = Sniperrifle.new(@player)
				end
				drop = Drop.new(weapon)
				drop.x = enemy.x
				drop.y = enemy.y
				@drops << drop
			end
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

		@drops.each do |drop|
			drop.draw(x, y)
		end

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
