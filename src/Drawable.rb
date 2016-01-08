class Drawable
    @@LOADED_IMAGES = {}

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

        unless @@LOADED_IMAGES.has_key?(sprite)
            @@LOADED_IMAGES[sprite] = Gosu::Image.new(sprite)
        end

        @width = @@LOADED_IMAGES[sprite].width
        @height = @@LOADED_IMAGES[sprite].height
    end
end
