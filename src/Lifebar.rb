require_relative 'Drawable.rb'

class Lifebar < Drawable
    def initialize(being)
        super()
        @being = being
        @x = 500
        @y = 9
        @width = 100
        @height = 15
        @progessWidth = @width
    end

    def update
        if @being.hp > 0
            ratio = @being.maxhp.to_f / @being.hp
            @progessWidth = (@width - 2) / ratio
        else
            @progessWidth = 0
        end
    end

    def draw(font)
        if @being.dead?
            font.draw('DEAD', @x + 40, @y - 4, 9, 1, 1, Gosu::Color::RED)
        else
            font.draw('HP: ', @x, @y - 4, 9, 1, 1, Gosu::Color::WHITE)
            Gosu.draw_rect(@x + 35, @y + 1, @width, @height, Gosu::Color::BLACK)
            Gosu.draw_rect(@x + 36, @y + 2, @width - 2, @height - 2, Gosu::Color::GRAY)
            Gosu.draw_rect(@x + 36, @y + 2, @progessWidth, @height - 2, Gosu::Color::GREEN)
        end
    end
end

class BossLifebar < Lifebar
    def initialize(boss)
        super
        @x = 500
        @y = 35
        @width = 300
        @height = 15
        @progessWidth = @width
    end

    def draw(font)
        font.draw('BOSS: ', @x, @y - 4, 9, 1, 1, Gosu::Color::WHITE)
        Gosu.draw_rect(@x + 35, @y + 1, @width, @height, Gosu::Color::BLACK)
        Gosu.draw_rect(@x + 36, @y + 2, @width - 2, @height - 2, Gosu::Color::GRAY)
        Gosu.draw_rect(@x + 36, @y + 2, @progessWidth, @height - 2, Gosu::Color::RED)
    end
end
