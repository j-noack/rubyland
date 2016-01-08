require_relative 'AbstractBeing.rb'
require_relative 'EnemyAI.rb'

class Enemy < AbstractBeing
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
        self.maxhp = 1
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
end

class BlobberEnemy < Enemy

	def initialize
		super
        @tileWidth = 60
        @tileHeight = 60
        loadSprite('assets/Blobber.bmp')
		@ai = BlobberAI.new(self)
	end
end
