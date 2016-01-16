require_relative 'AbstractBeing.rb'
require_relative 'EnemyAI.rb'
require_relative 'Lifebar.rb'
require_relative 'Weapons/GlobWeapon.rb'

class Enemy < AbstractBeing
    attr_accessor :target
    attr_accessor :score
    attr_accessor :damage
    attr_accessor :enabled
    attr_accessor :ai

    def initialize
        super
        @target = nil
        @ai = EnemyAI.new(self)
        @score = 5
        @damage = 1
        @enabled = false
        @soundName = ""
        @kamikaze = false
        self.maxhp = 1
        loadSound('assets/enemydeath.wav')
    end

    def playDeath
        if Cache.Assets.has_key?(@soundName)
            Cache.Assets[@soundName].play
        end
    end

    def kamikaze?
        return @kamikaze
    end

    def loadSound(file)
        unless Cache.Assets.has_key?(file)
            Cache.Assets[file] = Gosu::Sample.new(file)
        end

        @soundName = file
    end

    def update
        super(@target.x, @target.y) unless @target.nil?

        @ai.update
    end

    def calcNewX
        @ai.calcNewX
    end

    def calcNewY
        @ai.calcNewY
    end

    def moveX
        @x = calcNewX
    end

    def moveY
        @y = calcNewY
    end

    def randomize(target)
        resetHp
        @target = target
        @speed = rand(150) * 0.01 + 0.1
        @enabled = true
    end
end

class DefaultEnemy < Enemy

    def initialize
        super
        loadSprite('assets/EnemySpriteSheet.bmp')
    end

    def randomize(target)
        resetHp
        @target = target
        @speed = rand(75) * 0.01 + 0.75
        @enabled = true
    end
end

class CirclerEnemy < Enemy

	def initialize
		super
        loadSprite('assets/EnemySpriteSheet2.bmp')
		@ai = CirclerAI.new(self)
	end

    def randomize(target)
        resetHp
        @target = target
        @speed = rand(75) * 0.01 + 0.75
        @enabled = true
    end
end

class ChargerEnemy < Enemy

	def initialize
		super
        loadSprite('assets/EnemySpriteSheet3.bmp')
		@ai = ChargerAI.new(self)
	end

    def randomize(target)
        super
        @ai.moveAngle = @angle
    end
end

class BlobberEnemy < Enemy

	def initialize
		super
        @tileWidth = 60
        @tileHeight = 60
        loadSprite('assets/Blobber.bmp')
        @weapon = GlobberWeapon.new(self)
		@ai = BlobberAI.new(self)
        self.maxhp = 10
		@score = 10
	end

    def randomize(target)
        super
        @speed = 0.5
        @ai.speed = @speed
        @ai.moveAngle = @angle
    end
end

class BossEnemy < Enemy

	def initialize
		super
        @tileWidth = 131
        @tileHeight = 131
		loadSprite('assets/BossSpriteSheet.bmp')
		@ai = BossAI.new(self)
        @lifebar = BossLifebar.new(self)
        self.maxhp = 500
		@score = 1000
	end

    def randomize(target)
        super
        @speed = 0.1
        @ai.speed = @speed
        @ai.moveAngle = @angle
    end

    def draw(offsetX, offsetY, font)
        super
        @lifebar.draw(font)
    end

    def update
        super
        @lifebar.update
    end
end

class RocketEnemy < Enemy

	def initialize
		super
        @tileWidth = 40
        @tileHeight = 40
		loadSprite('assets/Rocket.bmp')
		@ai = RocketAI.new(self)
        @kamikaze = true
		@score = 0
	end

	def randomize(target)
		super
		@speed = 0.5
		@ai.speed = @speed
		@ai.moveAngle = @angle + 60 + rand(240)
	end

    def damage
        return 50
    end
end
