require_relative 'Drawable.rb'
require_relative 'Projectile.rb'

class Weapon < Drawable
	
	attr_accessor :triggered
	
	def initialize
        super
		@projectileSpeed = 2
		@projectileDuration = 200
		@delay = 200
		@triggered = false
	end
	
	def update(playerX, playerY, playerAngle)
		@x = playerX
		@y = playerY
		@angle = playerAngle
	end
	
	def getProjectiles
		projectiles = []
		if @triggered
			projectiles << Projectile.new(@x, @y, @angle, @projectileSpeed, @projectileDuration)
		end
		
		return projectiles
	end
end