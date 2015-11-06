require './AbstractBeing.rb'
require './EnemyAI.rb'

class Enemy < AbstractBeing

    attr_accessor :target

    def initialize
        super
        @target = nil
        @ai = EnemyAI.new(self)
        @sprite = "assets/enemy_1.png"
        @spriteImage = Gosu::Image.new(@enemyType.sprite)
    end

    def update
      @ai.update
    end

    def draw
      @spriteImage.draw(@x, @y, @z)
    end

end
