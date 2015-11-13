require 'gosu'
require_relative 'src/Highscore.rb'
require_relative 'src/Map.rb'
require_relative 'src/CollisionManager.rb'

class GameWindow < Gosu::Window
    @@VERSION = "0.1 ALPHA"

    attr_accessor :map
    attr_accessor :highscore
    attr_accessor :collisionManager

    def initialize
        super(1024, 768)
        self.caption = "Rubyland #{@@VERSION}"

        @font = Gosu::Font.new(25, { :name => "assets/Amble-Regular.ttf" })

        @highscore = Highscore.new
        @highscore.height = 480 / 10

        @map = Map.new(1024, 768 - @highscore.height)
        @map.y = @highscore.height

        @collisionManager = CollisionManager.new(@map)
    end

    def update
        @collisionManager.update
        @map.update
        @highscore.update
        
        #Player Controls:
        if Gosu::button_down? Gosu::KbW
          @map.player.move(0,-1)
        end
        if Gosu::button_down? Gosu::KbS
          @map.player.move(0,1)
        end
        if Gosu::button_down? Gosu::KbD
          @map.player.move(1,0)
        end
        if Gosu::button_down? Gosu::KbA
          @map.player.move(-1,0)
        end
    end

    def draw
        @highscore.draw(@font)
        @map.draw(@font)
    end

    def button_down(id)
      if id == Gosu::KbEscape
      # msp.player.move(x, y)
    end
    end

end

window = GameWindow.new
window.show
