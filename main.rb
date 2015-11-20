require 'gosu'
require_relative 'src/Highscore.rb'
require_relative 'src/Map.rb'

class GameWindow < Gosu::Window
    @@VERSION = "0.1 ALPHA"

    attr_accessor :map
    attr_accessor :highscore

    def initialize
        super(1024, 768)
        self.caption = "Rubyland #{@@VERSION}"

        @font = Gosu::Font.new(25, { :name => "assets/Amble-Regular.ttf" })

        @highscore = Highscore.new

        mapOffsetY = 32
        @map = Map.new(1024, 768 - mapOffsetY, 8, @highscore)
        @map.y = mapOffsetY
    end

    def update
        if (@map.stillAlive)
            @map.update(mouse_x, mouse_y)
            @highscore.update
        end
    end

    def draw
        @highscore.draw(@font)
        @map.draw(@font)
        @font.draw("Fps: #{Gosu::fps.to_i}", 1024 - 75, 4 ,999)
    end

    def button_down(id)
      if id == Gosu::KbEscape
        close
      end
    end

end

window = GameWindow.new
window.show
