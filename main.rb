require 'gosu'
require_relative 'src/Highscore.rb'
require_relative 'src/Lifebar.rb'
require_relative 'src/Map.rb'

class GameWindow < Gosu::Window
    @@VERSION = '0.1 ALPHA'

    attr_accessor :map
    attr_accessor :highscore

    def initialize
        super(1024, 768)
        self.caption = "Rubyland #{@@VERSION}"

        @font = Gosu::Font.new(25, name: 'assets/Amble-Regular.ttf')

        @highscore = Highscore.new
        mapOffsetY = 32
        @map = Map.new(1024, 768 - mapOffsetY, 8, @highscore)
        @map.y = mapOffsetY

        @lifeBar = Lifebar.new(@map.player)
    end

    def update
        if @map.stillAlive
            @map.update(mouse_x, mouse_y)
            @highscore.update
            @lifeBar.update
        end
    end

    def draw
        @map.draw(@font)
        @highscore.draw(@font)
        @lifeBar.draw(@font)
        @font.draw("Fps: #{Gosu.fps.to_i}", 1024 - 75, 4, 999)
    end

    def button_down(id)
        close if id == Gosu::KbEscape
    end
end

window = GameWindow.new
window.show
