require_relative 'Drawable.rb'

class Projectile < Drawable

	attr_accessor :duration
	attr_accessor :damage
	attr_accessor :source

    def initialize(startX, startY, angle, speed, duration, damage, source)
        super()
        @x = startX
        @y = startY
        @angle = angle
        @speed = speed
        @duration = duration
		@damage = damage
		@source = source
        loadSprite('assets/Bullet.bmp')
    end

    def update
		@duration -= 1
    end

	def calcNewX
		return @x + Math.cos((@angle - 90) * (Math::PI / 180)) * @speed
	end

	def calcNewY
		return @y + Math.sin((@angle - 90) * (Math::PI / 180)) * @speed
	end

	def fly
		@x = calcNewX
		@y = calcNewY
	end

    def draw(offsetX, offsetY)
        @spriteImage.draw_rot(@x + offsetX, @y + offsetY, @z, @angle)
    end
end
