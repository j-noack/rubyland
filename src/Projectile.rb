require_relative 'Drawable.rb'

class Projectile < Drawable
	
	def initialize(startX, startY, angle, speed, duration)
		super
		@x  = startX
		@y  = startY
		@angle = angle
		@speed = speed
		@duration = duration
		loadSprite("assets/Bullet_sprite_1.bmp")
	end

	def update
		@x += @speed
		@y += @speed
	end

	def draw(offsetX, offsetY)
		@spriteImage.draw_rot(@x + offsetX, @y + offsetY, @z, @angle)
	end

end
