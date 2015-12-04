class EnemyAI
    attr_accessor :enemy

    def initialize(enemy)
        @enemy = enemy
        @ratio = 0
    end

    def update
        distance = Math.sqrt(((@enemy.target.x - @enemy.x)**2) + ((@enemy.target.y - @enemy.y)**2))
        @ratio = @enemy.speed / distance if (distance != 0)
    end

    def calcNewX
		@enemy.x + (@enemy.target.x - @enemy.x) * @ratio
    end

    def calcNewY
		@enemy.y + (@enemy.target.y - @enemy.y) * @ratio
    end
end

class CirclerAI < EnemyAI

	attr_accessor :neg
	attr_accessor :moveAngle

	def initialize
		super
		if (rand(2))
			neg = -1
		else
			neg = 1
		end
	end
	
	def update
		super
		if distance > 450
			@moveAngle = (@enemy.angle + (75 * neg) + 360) % 360
		else
			@moveAngle = (@enemy.angle + ((distance / 6) * neg) + 360) % 360
		end
	
	def calcNewX
		@enemy.x + ((@enemy.target.x - @enemy.x) * @ratio) + (Math.sin(@moveAngle) * @speed)
	end
	
	def calcNewY
		@enemy.y + ((@enemy.target.y - @enemy.y) * @ratio) + (Math.cos(@moveAngle) * @speed)
	end
end
