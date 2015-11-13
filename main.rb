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
        @highscore.height = 32

        @map = Map.new(1024, 768 - @highscore.height)
        @map.y = @highscore.height

        @collisionManager = CollisionManager.new(@map)
    end

    def update
        @collisionManager.update
        @map.update(mouse_x, mouse_y)
        @highscore.update
    end

    def draw
        @highscore.draw(@font)
        @map.draw(@font)
    end

    def button_down(id)
      if id == Gosu::KbEscape
        close
      end
    end

end

window = GameWindow.new
window.show
