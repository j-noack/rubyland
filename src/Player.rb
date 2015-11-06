require './src/AbstractBeing.rb'

class Player < AbstractBeing

    def initialize
        super
        @spriteImage = Gosu::Image.new("assets/player_sprite.bmp")
    end

    def move(a,b)
      @x += (a * @speed)
      @y += (b * @speed)
    end

    # angle = 0, center_x = 0.5, center_y = 0.5, scale_x = 1, scale_y = 1, color = 0xff_ffffff, mode = :default)
    def draw
      @spriteImage.draw_rot(@x, @y, @z, angle=0.0)
    end

end
