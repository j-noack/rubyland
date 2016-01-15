require_relative 'Weapons/GlobWeapon.rb'
require_relative 'Enemy.rb'

class EnemyAI
    attr_accessor :enemy
    attr_accessor :speed
    attr_accessor :moveAngle
    attr_accessor :enemyGenerator

    def initialize(enemy)
        @enemy = enemy
        @enemyGenerator = nil
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

        unless @enemy.weapon.nil?
            @enemy.weapon.update(@enemy.x, @enemy.y, @moveAngle)
            @enemy.weapon.triggered = true
        end

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
		@enemy.maxhp = 500
		@turnspeed = 0.06
		@acceleration = 1.02
		@slowdown = 0.35
		@statetime0 = 1200
		@statetime1 = 150
        @statetime2 = 420
        @spawnFrequency = 30
		@timer = @statetime0
        @spawnTimer = @spawnFrequency
		@state = 0
	end

	def update
		@timer -= 1
		if (@state == 0)
            @spawnTimer -= 1
			@moveAngle = @enemy.angle
            if (@spawnTimer <= 0)
                @enemyGenerator.customSpawn(RocketEnemy, @enemy.x, @enemy.y)
                @spawnTimer =  @spawnFrequency
            end
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
                @timer = @statetime2
				@state = 2
			end
		end
		if (@state == 2)
			diff = @enemy.angle - @moveAngle
            if (diff < -180)
                diff += 360
            end
            if (diff > 180)
                diff -= 360
            end

			if (diff > 0)
				@moveAngle += @turnspeed
			else
				@moveAngle -= @turnspeed
			end
			if (diff > 90 || diff < -90)
                @speed = @speed - @slowdown
			else
                if (@speed < (@enemy.target.width - 5))
                    @speed = @speed * @acceleration
                end
			end
			if (@speed <= 0 || @timer <= 0)
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

class RocketAI < EnemyAI

	def initialize(being)
		super
		@turnspeed = 0.05
		@turnAcceleration = 0.002
		@speedup = 0.005
	end

	def update
		diff = @enemy.angle - @moveAngle
        if (diff < -180)
            diff += 360
        end
        if (diff > 180)
            diff -= 360
        end
		if (diff > 0)
			@moveAngle += @turnspeed
		else
			@moveAngle -= @turnspeed
		end
		@turnspeed += @turnAcceleration
		@speed += @speedup
	end

	def calcNewX
		@enemy.x + (Math.sin(@moveAngle / (180 / Math::PI)) * @speed)
	end

	def calcNewY
		@enemy.y - (Math.cos(@moveAngle / (180 / Math::PI)) * @speed)
	end
end
