require './src/Drawable.rb'
require './src/Player.rb'

class Map < Drawable

    attr_accessor :player
    attr_accessor :enemies

    def initialize(width, height)
        super()

        @width = width
        @height = height
        @player = Player.new
        @enemies = []
        @backgroundImage = Gosu::Image.new("boxhead.jpg")
    end

    def update
    end

    def draw
        @backgroundImage.draw(@x, @y, @z)
    end

end
