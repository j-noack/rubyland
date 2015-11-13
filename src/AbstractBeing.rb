require_relative 'Drawable.rb'

class AbstractBeing < Drawable

    attr_accessor :speed
    attr_accessor :hp
    attr_accessor :weapon

    def initialize
        super
        @z = 5
        @speed = 2
        @hp = 1
        @weapon = nil
    end

    def damage
        return 5
    end

    def draw(offsetX, offsetY)
      if !spriteImage.nil?
        @spriteImage.draw_rot(@x + offsetX, @y + offsetY, @z, angle = 0.0)
      end
    end
end
