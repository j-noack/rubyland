require_relative 'AbstractBeing.rb'

class Player < AbstractBeing

	attr_accessor :keyW
	attr_accessor :keyA
	attr_accessor :keyS
	attr_accessor :keyD
	attr_accessor :angle
	attr_accessor :crosshair

    def initialize
        super
				loadSprite("assets/Player.bmp")
				@crosshair = Crosshair.new
				@keyW = 0
				@keyA = 0
				@keyS = 0
				@keyD = 0
		end

		def	update(mouse_x, mouse_y)
			@crosshair.update(mouse_x, mouse_y)
			if(mouse_y-self.y<0)
				@angle =  180/Math::PI * Math.asin((@crosshair.x-@x)/Math.sqrt((@crosshair.x-@x)**2+(@crosshair.y-@y)**2))
			end
			if(mouse_y-self.y>0)
				@angle = 90  + 180/Math::PI * Math.acos(((@crosshair.x-@x))/Math.sqrt((@crosshair.x-@x)**2+(@crosshair.y-@y)**2))
			end
			puts ((@crosshair.x-@x)/Math.sqrt((@crosshair.x-@x)**2+(@crosshair.y-@y)**2))
			# puts @angle

			@keyW = Gosu::button_down?(Gosu::KbW) ? 1 : 0
			@keyS = Gosu::button_down?(Gosu::KbS) ? 1 : 0
	    @keyA = Gosu::button_down?(Gosu::KbA) ? 1 : 0
			@keyD = Gosu::button_down?(Gosu::KbD) ? 1 : 0
		end

		def calcNewX
			a = Math.sqrt((((@keyS - @keyW) * @speed) ** 2 ) / 2)
			a = (a == 0) ? @speed : a
			return @x + (@keyD - @keyA) * a
		end

		def calcNewY
			b = Math.sqrt((((@keyD - @keyA) * @speed) ** 2 ) / 2)
			b = (b == 0) ? @speed : b
			return @y + (@keyS - @keyW) * b
		end

    def move
      @x = calcNewX
      @y = calcNewY
      @spriteImage.draw_rot(@x, @y, @z, @angle)
			@crosshair.draw
    end


end
