class Drawable
    attr_accessor :x
    attr_accessor :y
    attr_accessor :z
    attr_accessor :width
    attr_accessor :height
    attr_accessor :spriteImage
    attr_accessor :angle

    def initialize
        @x = 0
        @y = 0
        @z = 0
        @angle = 0.0
        @width = 0
        @height = 0
        @spriteImage = nil
    end

    def draw(font)
    end

    def loadSprite(sprite)
      @spriteImage = Gosu::Image.new(sprite)
      @width = @spriteImage.width
      @height = @spriteImage.height
    end

end
