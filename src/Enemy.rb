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
      @ai.update
    end

end
