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
        loadSprite('assets/PlayerSpriteSheet.bmp')
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

    def move
        @x = calcNewX
        @y = calcNewY
    end
end
