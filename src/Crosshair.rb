require_relative 'Drawable.rb'

class Crosshair < Drawable

  def initialize
    super
    @spriteImage = Gosu::Image.new("assets/Crosshair.bmp")

  end

  def update(mouse_x, mouse_y)
    @y = mouse_y
    @x = mouse_x
    @z = 3
  end

  def draw
    @spriteImage.draw_rot(@x, @y, @z, angle= 0.0)
  end

end
