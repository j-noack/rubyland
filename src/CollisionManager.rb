require_relative 'BattleManager.rb'

class CollisionManager
    attr_accessor :map

    def initialize(map)
        @map = map
        @battleManager = BattleManager.new
    end

    def canPlayerMoveX?
        player = @map.player
        unless checkPlayerCollisionWithEnemiesX(player)
            unless mapBorderCollision(player.calcNewX, player.calcNewY, player.width, player.height)
                return true
            end
        end
        false
    end

    def canPlayerMoveY?
        player = @map.player
        unless checkPlayerCollisionWithEnemiesY(player)
            unless mapBorderCollision(player.calcNewX, player.calcNewY, player.width, player.height)
                return true
            end
        end
        false
    end

    def canEnemyMoveX?(enemy)
        unless checkEnemyWithPlayerCollisionX(enemy)
            unless mapBorderCollision(enemy.calcNewX, enemy.calcNewY, enemy.width, enemy.height)
                return true
            end
        end
        false
    end

    def canEnemyMoveY?(enemy)
        unless checkEnemyWithPlayerCollisionY(enemy)
            unless mapBorderCollision(enemy.calcNewX, enemy.calcNewY, enemy.width, enemy.height)
                return true
            end
        end
        false
    end

    def canProjectileFly?(projectile)
        !mapBorderCollision(projectile.calcNewX, projectile.calcNewY, projectile.width, projectile.height)
    end

    def checkEnemyWithPlayerCollisionX(enemy)
        player = @map.player
        if checkCircleCollisionX(enemy, player)
            return true
        end
        false
    end

    def checkEnemyWithPlayerCollisionY(enemy)
        player = @map.player
        if checkCircleCollisionY(enemy, player)
            @battleManager.doPlayerCollisionWithEnemy(player, enemy)
            return true
        end
        false
    end

    def checkPlayerCollisionWithEnemiesX(player)
        enemies = @map.enemies
        enemies.each do |enemy|
            return true if checkCircleCollisionX(player, enemy)
        end
        false
    end

    def checkPlayerCollisionWithEnemiesY(player)
        enemies = @map.enemies
        enemies.each do |enemy|
            return true if checkCircleCollisionY(player, enemy)
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

    def checkCircleCollisionX(obj1, obj2)
        if getDistanceX(obj1, obj2) < (obj1.width / 2) + (obj2.width / 2)
            return true
        else
            return false
        end
    end

    def checkCircleCollisionY(obj1, obj2)
        if getDistanceY(obj1, obj2) < (obj1.width / 2) + (obj2.width / 2)
            return true
        else
            return false
        end
    end

    def getDistance(obj1, obj2)
        Math.sqrt(((obj1.calcNewX - obj2.calcNewX)**2) + ((obj1.calcNewY - obj2.calcNewY)**2))
    end

    def getDistanceX(obj1, obj2)
        Math.sqrt(((obj1.calcNewX - obj2.calcNewX)**2) + ((obj1.@y - obj2.calcNewY)**2))
    end

    def getDistanceY(obj1, obj2)
        Math.sqrt(((obj1.@x	- obj2.calcNewX)**2) + ((obj1.calcNewY - obj2.calcNewY)**2))
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
