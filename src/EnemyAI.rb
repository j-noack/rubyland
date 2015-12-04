class EnemyAI
    attr_accessor :enemy

    def initialize(enemy)
        @enemy = enemy
        @ratio = 0
        @distance = 0
    end

    def update
        @distance = Math.sqrt(((@enemy.target.x - @enemy.x)**2) + ((@enemy.target.y - @enemy.y)**2))
        @ratio = @enemy.speed / @distance if (@distance != 0)
    end

    def calcNewX
		@enemy.x + (@enemy.target.x - @enemy.x) * @ratio
    end

    def calcNewY
		@enemy.y + (@enemy.target.y - @enemy.y) * @ratio
    end
end

class CirclerAI < EnemyAI

	def initialize(being)
		super
		@neg = 1#rand(2) == 0 ? -1 : 1
        @moveAngle = 0
	end

	def update
		super
		if @distance > 450
			@moveAngle = (@enemy.angle + (75 * @neg) + 360) % 360
		else
			@moveAngle = (@enemy.angle + ((@distance / 6) * @neg) + 360) % 360
		end
        puts @enemy.angle
    end

	def calcNewX
		@enemy.x + (Math.cos(@moveAngle / (180 / Math::PI)) * @enemy.speed)
	end

	def calcNewY
		@enemy.y + (Math.sin(@moveAngle / (180 / Math::PI)) * @enemy.speed)
	end
end
