require_relative 'Drawable.rb'

class Crosshair < Drawable
    def initialize
        super
        loadSprite('assets/Crosshair2.bmp')
    end

    def update(mouse_x, mouse_y)
        @y = mouse_y
        @x = mouse_x
        @z = 6
    end

    def draw(offsetX, offsetY)
        mySprite.draw_rot(@x + offsetX, @y + offsetY - 20, @z, 0.0)
    end
end
