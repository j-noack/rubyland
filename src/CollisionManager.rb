
class CollisionManager

	attr_accessor :map

	def initialize(map)
		@map = map
	end

	def canPlayerMove?
		player = @map.player
		return !mapBorderCollision(player.calcNewX, player.calcNewY, player.width, player.height)
	end

	def checkCircleCollision(obj1, obj2)
		if (getDistance(obj1, obj2) < (obj1.width / 2) + (obj2.width / 2))
			return true
		else
			return false
		end
	end

	def getDistance(obj1, obj2)
		return Math.sqrt(((obj1.x - obj2.x) ** 2) + ((obj1.y - obj2.y) ** 2))
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
