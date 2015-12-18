require_relative 'BattleManager.rb'

class CollisionManager
    attr_accessor :map

    def initialize(map)
        @map = map
        @battleManager = BattleManager.new
    end

    def canPlayerMove?
        player = @map.player
        unless checkPlayerCollisionWithEnemies(player)
            return true
        end
        false
    end

    def canPlayerMoveBorderX?
        player = @map.player
        unless mapBorderCollision(player.calcNewX, player.y, player.width, player.height)
            return true
        end
        false
    end

    def canPlayerMoveBorderY?
        player = @map.player
        unless mapBorderCollision(player.x, player.calcNewY, player.width, player.height)
            return true
        end
        false
    end

    def canEnemyMove?(enemy)
        unless checkEnemyWithPlayerCollision(enemy)
            return true
        end
        false
    end

    def canEnemyMoveBorderX?(enemy)
        unless mapBorderCollision(enemy.calcNewX, enemy.y, enemy.width, enemy.height)
            return true
        end
        false
    end

    def canEnemyMoveBorderY?(enemy)
        unless mapBorderCollision(enemy.x, enemy.calcNewY, enemy.width, enemy.height)
            return true
        end
        false
    end

    def canProjectileFly?(projectile)
        !mapBorderCollision(projectile.calcNewX, projectile.calcNewY, projectile.width, projectile.height)
    end

    def checkEnemyWithPlayerCollision(enemy)
        player = @map.player
        if checkCircleCollision(enemy, player)
            @battleManager.doPlayerCollisionWithEnemy(player, enemy)
            return true
        end
        false
    end

    def checkPlayerCollisionWithEnemies(player)
        enemies = @map.enemies
        enemies.each do |enemy|
            return true if checkCircleCollision(player, enemy)
        end
        false
    end

    def checkProjectileCollisionsWithBeing(projectile)
        enemies = @map.enemies
        enemies.each do |enemy|
            if checkCircleCollisionWithBeingAndProjectile(enemy, projectile)
                @battleManager.doProjectileCollisionWithBeing(enemy, projectile)
            end
        end

        player = @map.player
        if checkCircleCollisionWithBeingAndProjectile(player, projectile)
            puts 'Collision with player'
            @battleManager.doCollisionWithBeing(player, projectile)
        end
    end

	def checkPlayerCollisionWithDrops
		player = @map.player
		drops = @map.drops
		drops.each do |drop|
			if checkCircleCollision(player, drop)
				player.weapon = drop.weapon
                drops.delete(drop)
			end
		end
	end

    def checkCircleCollisionWithBeingAndProjectile(being, projectile)
        return false if being == projectile.source

        checkCircleCollision(being, projectile)
    end

    def checkCircleCollision(obj1, obj2)
        if getDistance(obj1, obj2) < (obj1.width / 2) + (obj2.width / 2)
            return true
        else
            return false
        end
    end

    def getDistance(obj1, obj2)
        Math.sqrt(((obj1.calcNewX - obj2.calcNewX)**2) + ((obj1.calcNewY - obj2.calcNewY)**2))
    end

    def mapBorderCollision(x, y, w, h)
        if checkLeft(x, w) || checkRight(x, w) || checkUp(y, h) || checkDown(y, h)
            return true
        else
            return false
        end
    end

    def checkLeft(x, w)
        if x - (w / 2) < @map.borderWidth
            return true
        else
            return false
        end
    end

    def checkRight(x, w)
        if x + (w / 2) > @map.width - @map.borderWidth
            return true
        else
            return false
        end
    end

    def checkUp(y, h)
        if y - (h / 2) < @map.borderWidth
            return true
        else
            return false
        end
    end

    def checkDown(y, h)
        if y + (h / 2) > @map.height - @map.borderWidth
            return true
        else
            return false
        end
    end
end
