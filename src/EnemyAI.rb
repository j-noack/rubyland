require_relative 'Weapons/GlobWeapon.rb'

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
		@neg = rand(2) == 0 ? -1 : 1
        @moveAngle = 0
	end

    def update
		super
		if @distance > 450
			@moveAngle = @enemy.angle
		else
			@moveAngle = (@enemy.angle + ((@distance / 6) * @neg) + 360) % 360
		end
    end

	def calcNewX
		@enemy.x + (Math.sin(@moveAngle / (180 / Math::PI)) * @enemy.speed)
	end

	def calcNewY
		@enemy.y - (Math.cos(@moveAngle / (180 / Math::PI)) * @enemy.speed)
	end
end

class ChargerAI < EnemyAI

    def initialize(being)
		super
        @moveAngle = @enemy.angle
        @speed = 4#@enemy.speed
        @timer = 1 + rand(150)
    end

    def update
		super
        @timer = @timer - 1
        if @timer == 0
            @moveAngle = @enemy.angle
            @timer = 150
        end
    end

	def calcNewX
		@enemy.x + (Math.sin(@moveAngle / (180 / Math::PI)) * @speed)
	end

	def calcNewY
		@enemy.y - (Math.cos(@moveAngle / (180 / Math::PI)) * @speed)
	end
end

class BlobberAI < EnemyAI

    def initialize(being)
		super
        #@weapon = GlobberWeapon.new(self)
        @enemy.maxhp = 5
        @speed = @enemy.speed;
        @moveAngle = 0#rand(360)
    end

    def update
		super
        @speed *= 1.05
        if @speed > @enemy.speed / 2
            @speed = @enemy.speed / 8
        end

        if @moveAngle < @enemy.angle && @moveAngle < @enemy.angle + 5
            @moveAngle += 5
        end

        if @moveAngle > @enemy.angle && @moveAngle > @enemy.angle - 5
            @moveAngle -= 5
        end
        #unless @weapon.nil?
        #    @weapon.update(@x, @y, @moveAngle)
		#	@weapon = GlobberWeapon.new(self)
        #    @weapon.triggered = true
        #end

    end

	def calcNewX
		@enemy.x + (Math.sin(@moveAngle / (180 / Math::PI)) * @speed)
	end

	def calcNewY
		@enemy.y - (Math.cos(@moveAngle / (180 / Math::PI)) * @speed)
	end
end

class BossAI < EnemyAI

	def initialize(being)
		super
		@moveAngle = @enemy.angle
		@speed = @enemy.speed
		@enemy.maxhp = 50
		@turnspeed = 0.5
		@acceleration = 1.05
		@slowdown = 0.1
		@statetime0 = 600
		@statetime1 = 30
		@timer = @statetime0
		@state = 0
	end
	
	def update
		@timer--
		if (@state == 0)
			@moveAngle = @enemy.angle
			if (@timer <= 0)
				@speed = 0
				@timer = @statetime1
				@state = 1
			end
		end
		if (@state == 1)
			@moveAngle = @enemy.angle
			if (@timer <= 0)
				@speed = 0.1
				@state = 2
			end
		end
		if (@state == 2)
			diff = @enemy.angle - @moveAngle
			if (diff > 180)
				diff -= 360
			end
			if (diff < -180)
				diff += 360
			end
			if (@enemy.angle != @moveAngle)
				if (diff >= 0)
					@moveAngle += @turnspeed
				else
					@moveAngle -= @turnspeed
				end
			end
			if (diff < 90 || diff > -90) 
				@speed = @speed * @acceleration
			else
				@speed = @speed - @slowdown
			end
			if (@speed <= 0)
				@speed = @enemy.speed
				@timer = @statetime0
				@state = 0
			end
		end
	end
	
	def calcNewX
		@enemy.x + (Math.sin(@moveAngle / (180 / Math::PI)) * @speed)
	end
	
	def calcNewY
		@enemy.y - (Math.cos(@moveAngle / (180 / Math::PI)) * @speed)
	end
end
