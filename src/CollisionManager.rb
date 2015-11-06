
class CollisionManager

	attr_accessor :map
	
	def initialize(map)
		@map = map
	end
	
    def update
		# player => @map.player
		# enemies => @map.enemies
		
		
    end
	
	def checkCircleCollision(obj1, obj2)
		if (getDistance(obj1, obj2) < (obj1.width / 2) + (obj2.width / 2))
			return true
		else
			return false
	end
	
	def getDistance(obj1, obj2)
		return Math.sqrt(((obj1.x - obj2.x) ** 2) + ((obj1.y - obj2.y) ** 2)) 
	end
	
	def mapBorderCollision(map, obj)
		if (checkLeft(obj) || checkRight(obj, map) || checkUp(obj) || checkDown(obj, map))
			return true
		else 
			return false
	end
	
	def checkLeft(obj)
		if (obj.x - obj.width < 0)
			return true
		else
			return false
	end
	
	def checkRight(obj, map)
		if (obj.x + obj.width > map.width)
			return true
		else
			return false
	end
	
	def checkUp(obj)
		if (obj.y - obj.height < 0)
			return true
		else
			return false
	end
	
	def checkDown(obj, map)
		if (obj.y + obj.height > map.height)
			return true
		else
			return false
	end
end
