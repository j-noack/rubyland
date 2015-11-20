require_relative 'Drawable.rb'

class Bullet < Drawable
  attr_accessor :Vy
  attr_accessor :Vx
  attr_accessor :ratio

  def initialize
    super
    @spriteImage = Gosu::Image.new('assets/Bullet_sprite_1.bmp')
    # Initial bulllet Position = Player Position
    @x  = @player.x
    @y  = @player.y
    @speed = 300
    # Direction, not ratio'd
    @Vy = @crosshair.y - @player.y
    @Vx = @crosshair.x - @player.x
    # Bullet Speed (stolen from AI) (only needed once)
    distance = Math.sqrt(((@crosshair.x - @player.x)**2) + ((@crosshair.y - @player.y)**2))
    @ratio = @speed / distance

    # Bullet sprite orientation (Only needed once)
    if @crosshair.y - y < 0
      @angle = 180 / Math::PI * Math.asin((@crosshair.x - @x) / Math.sqrt((@crosshair.x - @x)**2 + (@crosshair.y - @y)**2))
    end
    if @crosshair.y - y > 0
      @angle = 90 + 180 / Math::PI * Math.acos((@crosshair.x - @x) / Math.sqrt((@crosshair.x - @x)**2 + (@crosshair.y - @y)**2))
    end
  end

  def update
    @x += (@Vx * @ratio)
    @y += (@Vy * @ratio)
  end

  def draw(offsetX, offsetY)
    @spriteImage.draw_rot(@x + offsetX, @y + offsetY, @z, @angle)
  end
end
