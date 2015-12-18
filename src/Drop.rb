require_relative 'Drawable.rb'

class Drop < Drawable
    attr_accessor :weapon
	attr_accessor :duration

    def initialize(weapon)
        super()
        @weapon = weapon
		loadSprite('assets/' + @weapon.name + '.bmp')
		@duration = 600
    end

    def update
		@duration = @duration - 1
    end

    def draw(offsetX, offsetY)
        @spriteImage.draw_rot(@x + offsetX, @y + offsetY, @z, 0.0)
    end

	def calcNewX
		return x
	end

	def calcNewY
		return y
	end

end
