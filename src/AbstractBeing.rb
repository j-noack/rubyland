require_relative 'Drawable.rb'

class AbstractBeing < Drawable
    attr_reader :maxhp
    attr_accessor :hp
    attr_accessor :speed
    attr_accessor :weapon
    attr_accessor :tileWidth
    attr_accessor :tileHeigth

    def initialize
        super
        @z = 5
        @speed = 2
        @weapon = nil
        @tileWidth = 41
        @tileHeight = 41
        @spriteName = ""
        self.maxhp = 600
    end

    def maxhp=(value)
        @maxhp = value
        resetHp
    end

    def resetHp
        @hp = @maxhp
    end

    def loadSprite(sprite)
        @spriteName = sprite

        unless Cache.Assets.has_key?(sprite)
            Cache.Assets[sprite] = Gosu::Image.load_tiles(sprite, @tileWidth, @tileHeight)
        end

        spriteImage = Cache.Assets[sprite][0]
        @width = spriteImage.width - 8
        @height = spriteImage.height - 8
    end

    def damage
        5
    end

    def dead?
        @hp <= 0
    end

    # Orientation of the Being
    def update(focus_x, focus_y)
        if focus_y - y < 0
            @angle = 180 / Math::PI * Math.asin((focus_x - @x) / Math.sqrt((focus_x - @x)**2 + (focus_y - @y)**2))
        end

        if focus_y - y > 0
            @angle = 90 + 180 / Math::PI * Math.acos(((focus_x - @x)) / Math.sqrt((focus_x - @x)**2 + (focus_y - @y)**2))
        end

        @angle += 360 if @angle < 0
    end

    def draw(offsetX, offsetY, font)
        mySprite[(((@angle + 22.5) % 360) / 45).to_i].draw_rot(@x + offsetX, @y + offsetY - 20, @z, 0.0)
    end

    def getProjectiles
        projectiles = []

        unless @weapon.nil?
            projectiles.concat(@weapon.fire) if @weapon.triggered
        end

        projectiles
    end
end
