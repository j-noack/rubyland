require_relative 'Drawable.rb'

class Lifebar < Drawable
    def initialize(player)
        super()
        @player = player
        @x = 400
        @y = 9
        @width = 100
        @height = 15
        @progessWidth = @width
    end

    def update
        if @player.hp > 0
            ratio = @player.maxhp / @player.hp
            @progessWidth = (@width - 2) / ratio
        else
            @progessWidth = 0
        end
    end

    def draw(font)
        if @player.dead?
            font.draw('DEAD', @x + 40, @y - 4, 9, 1, 1, Gosu::Color::RED)
        else
            font.draw('HP: ', @x, @y - 4, 9, 1, 1, Gosu::Color::WHITE)
            Gosu.draw_rect(@x + 35, @y + 1, @width, @height, Gosu::Color::BLACK)
            Gosu.draw_rect(@x + 36, @y + 2, @width - 2, @height - 2, Gosu::Color::GRAY)
            Gosu.draw_rect(@x + 36, @y + 2, @progessWidth, @height - 2, Gosu::Color::GREEN)
        end
    end
end
