require_relative 'Drawable.rb'

class Drop < Drawable
    attr_accessor :weapon
	attr_accessor :duration

    def initialize(weapon)
        super()
        @weapon = weapon
		loadSprite('assets/' + @weapon.name + '.bmp')
		@duration = 600
        loadSound('assets/weaponpickup.wav')
    end

    def loadSound(file)
        unless Cache.Assets.has_key?(file)
            Cache.Assets[file] = Gosu::Sample.new(file)
        end

        @soundName = file
    end

    def playSound
        if Cache.Assets.has_key?(@soundName)
            Cache.Assets[@soundName].play(0.55)
        end
    end

    def update
		@duration = @duration - 1
    end

    def draw(offsetX, offsetY)
        mySprite.draw_rot(@x + offsetX, @y + offsetY, @z, 0.0)
    end

	def calcNewX
		return x
	end

	def calcNewY
		return y
	end

end
