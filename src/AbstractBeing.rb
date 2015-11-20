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

    #Orientation of the Being
    def update(focus_x, focus_y)
      if (focus_y - self.y < 0)
        @angle =  180 / Math::PI * Math.asin((focus_x - @x) / Math.sqrt((focus_x - @x)**2 + (focus_y - @y)**2))
      end

      if (focus_y - self.y > 0)
        @angle = 90  + 180 / Math::PI * Math.acos(((focus_x - @x)) / Math.sqrt((focus_x - @x)** 2 + (focus_y - @y)**2))
      end
    end

    def draw(offsetX, offsetY)
      if !spriteImage.nil?
        @spriteImage.draw_rot(@x + offsetX, @y + offsetY, @z, @angle)
      end
    end
	
	def getProjectiles
		projectiles = []
		
		if !@weapon.nil?
			if @weapon.triggered
				projectiles << @weapon.getProjectiles
			end
		end
		
		return projectiles
	end
	
end
