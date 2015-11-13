require_relative 'AbstractBeing.rb'
require_relative 'EnemyAI.rb'

class Enemy < AbstractBeing

    attr_accessor :target

    def initialize
        super
        @target = nil
        @ai = EnemyAI.new(self)
        loadSprite("assets/Enemy.bmp")
    end

    def update
      if (!@target.nil?)
        super(@target.x, @target.y)
      end

      @ai.update
    end

end
