require_relative 'BattleManager.rb'

class CollisionManager

	attr_accessor :map

	def initialize(map)
		@map = map
		@battleManager = BattleManager.new
	end

	def canPlayerMove?
		player = @map.player
		if (!checkPlayerCollisionWithEnemies(player))
			if (!mapBorderCollision(player.calcNewX, player.calcNewY, player.width, player.height))
				return true
			end
		end
		return false
	end

	def canEnemyMove?(enemy)
		if (!checkEnemyWithPlayerCollision(enemy))
			if (!mapBorderCollision(enemy.calcNewX, enemy.calcNewY, enemy.width, enemy.height))
				return true
			end
		end
		return false
	end

	def canProjectileFly?(projectile)
		return !mapBorderCollision(projectile.calcNewX, projectile.calcNewY, projectile.width, projectile.height)
	end

	def checkEnemyWithPlayerCollision(enemy)
		player = @map.player
		if checkCircleCollision(enemy, player)
			@battleManager.doPlayerCollisionWithEnemy(player, enemy)
			return true
		end
		return false
	end

	def checkPlayerCollisionWithEnemies(player)
		enemies = @map.enemies
		enemies.each do |enemy|
			if checkCircleCollision(player, enemy)
				return true
			end
		end
		return false
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
			puts "Collision with player"
			@battleManager.doCollisionWithBeing(player, projectile)
		end
	end

	def checkCircleCollisionWithBeingAndProjectile(being, projectile)
		return false if (being == projectile.source)

		return checkCircleCollision(being, projectile)
	end

	def checkCircleCollision(obj1, obj2)
		if (getDistance(obj1, obj2) < (obj1.width / 2) + (obj2.width / 2))
			return true
		else
			return false
		end
	end

	def getDistance(obj1, obj2)
		return Math.sqrt(((obj1.calcNewX - obj2.calcNewX) ** 2) + ((obj1.calcNewY - obj2.calcNewY) ** 2))
	end

	def mapBorderCollision(x, y, w, h)
		if (checkLeft(x, w) || checkRight(x, w) || checkUp(y, h) || checkDown(y, h))
			return true
		else
			return false
		end
	end

	def checkLeft(x, w)
		if (x - (w / 2) < @map.borderWidth)
			return true
		else
			return false
		end
	end

	def checkRight(x, w)
		if (x + (w / 2) > @map.width - @map.borderWidth)
			return true
		else
			return false
		end
	end

	def checkUp(y, h)
		if (y - (h / 2) < @map.borderWidth)
			return true
		else
			return false
		end
	end

	def checkDown(y, h)
		if (y + (h / 2) > @map.height - @map.borderWidth)
			return true
		else
			return false
		end
	end
end
