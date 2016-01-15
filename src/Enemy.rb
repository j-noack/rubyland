require_relative 'AbstractBeing.rb'
require_relative 'EnemyAI.rb'
require_relative 'Weapons/GlobWeapon.rb'

class Enemy < AbstractBeing
    @@LOADED_SOUNDS = {}

    attr_accessor :target
    attr_accessor :score
    attr_accessor :damage
    attr_accessor :enabled

    def initialize
        super
        @target = nil
        @ai = EnemyAI.new(self)
        @score = 5
        @damage = 1
        @enabled = false
        @soundName = ""
        self.maxhp = 1
        loadSound('assets/weaponpickup.wav')
    end

    def playDeath
        if @@LOADED_SOUNDS.has_key?(@soundName)
            @@LOADED_SOUNDS[@soundName].play
        end
    end

    def loadSound(file)
        unless @@LOADED_SOUNDS.has_key?(file)
            @@LOADED_SOUNDS[file] = Gosu::Sample.new(file)
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
end

class CirclerEnemy < Enemy

	def initialize
		super
        loadSprite('assets/EnemySpriteSheet2.bmp')
		@ai = CirclerAI.new(self)
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
	end

    def randomize(target)
        super
        @speed = 0.1
        @ai.speed = @speed
        @ai.moveAngle = @angle
    end
end

class BossEnemy < Enemy

	def initialize
		super
		loadSprite('assets/EnemySpriteSheet.bmp')
		@ai = BossAI.new(self)
	end

    def randomize(target)
        super
        @speed = 0.1
        @ai.speed = @speed
        @ai.moveAngle = @angle
    end
end
