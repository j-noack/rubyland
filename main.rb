require 'gosu'
require_relative 'src/Highscore.rb'
require_relative 'src/Lifebar.rb'
require_relative 'src/Map.rb'

class GameWindow < Gosu::Window
    @@VERSION = '1.0'
    @@SCREEN_WIDTH = 1366
    @@SCREEN_HEIGHT = 768

    def initialize
        super(@@SCREEN_WIDTH, @@SCREEN_HEIGHT, true)
        self.caption = "Rubyland #{@@VERSION}"

        @font = Gosu::Font.new(25, name: 'assets/Amble-Regular.ttf')

        @highscore = Highscore.new
        mapOffsetY = 32
        @map = Map.new(@@SCREEN_WIDTH, @@SCREEN_HEIGHT - mapOffsetY, 8, @highscore)
        @map.y = mapOffsetY

        @player = @map.player
        @lifeBar = Lifebar.new(@player)
    end

    def update
        unless @map.player.dead?
            @map.update(mouse_x, mouse_y)
            @highscore.update
            @lifeBar.update
        end
    end

    def draw
        @map.draw(@font)
        @highscore.draw(@font)
        @lifeBar.draw(@font)
        weapon = @player.weapon
        weaponName = "---"
        unless weapon.nil?
            weaponName = weapon.name
        end

        @font.draw("Weapon: #{weaponName}", @@SCREEN_WIDTH - 450, 4, 999)
        @font.draw("Spawned: #{@map.enemyGenerator.count}", @@SCREEN_WIDTH - 250, 4, 999)
        @font.draw("Wave: #{@map.waveCount}", @lifeBar.x + @lifeBar.width + 50, 4, 9)
        @font.draw("Fps: #{Gosu.fps.to_i}", @@SCREEN_WIDTH - 75, 4, 999)
    end

    def button_down(id)
        close if id == Gosu::KbEscape
    end
end

window = GameWindow.new
window.show
