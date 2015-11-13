require 'gosu'
require './src/Highscore.rb'
require './src/Map.rb'
require './src/CollisionManager.rb'

class GameWindow < Gosu::Window

    attr_accessor :map
    attr_accessor :highscore
    attr_accessor :collisionManager

    def initialize
        super(640, 480)
        self.caption = "Rubyland"

        @highscore = Highscore.new
        @highscore.height = 480 / 10

        @map = Map.new(640, 480 - @highscore.height)
        @map.y = @highscore.height

        @collisionManager = CollisionManager.new(@map)

    end

    def update
        @collisionManager.update
        @map.update
    end

    def draw
        @highscore.draw
        @map.draw
    end

    def button_down(id)
      if id == Gosu::KbEscape
      # msp.player.move(x, y)
    end
    end

end

window = GameWindow.new
window.show
