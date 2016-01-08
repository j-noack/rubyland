require_relative 'Drawable.rb'

class Crosshair < Drawable
    def initialize
        super
        loadSprite('assets/Crosshair2.bmp')
    end

    def update(mouse_x, mouse_y)
        @y = mouse_y
        @x = mouse_x
        @z = 3
    end

    def draw(offsetX, offsetY)
        @@LOADED_IMAGES[@spriteName].draw_rot(@x + offsetX, @y + offsetY - 20, @z, 0.0)
    end
end
