require_relative 'Cache.rb'

class Drawable
    attr_accessor :x
    attr_accessor :y
    attr_accessor :z
    attr_accessor :width
    attr_accessor :height
    attr_accessor :spriteName
    attr_accessor :angle

    def initialize
        @x = 0
        @y = 0
        @z = 0
        @angle = 0.0
        @width = 0
        @height = 0
        @spriteName = ""
    end

    def draw(font)
    end

    def loadSprite(sprite)
        @spriteName = sprite

        unless Cache.Assets.has_key?(sprite)
            Cache.Assets[sprite] = Gosu::Image.new(sprite)
        end

        @width = Cache.Assets[sprite].width
        @height = Cache.Assets[sprite].height
    end

    def mySprite
        return Cache.Assets[@spriteName]
    end
end
