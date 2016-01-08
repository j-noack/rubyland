require_relative 'Drawable.rb'

class Projectile < Drawable
    attr_accessor :duration
    attr_accessor :damage
    attr_accessor :source
    attr_accessor :pierce
    attr_accessor :durability

    def initialize(startX, startY, angle, speed, duration, damage, source)
        super()
        @x = startX
        @y = startY
        @angle = angle
        @speed = speed
        @duration = duration
        @damage = damage
        @source = source
        @pierce = false
        @durability = 1
        loadSprite('assets/Bullet.bmp')
    end

    def update
        @duration -= 1
    end

    def calcNewX
        @x + Math.cos((@angle - 90) * (Math::PI / 180)) * @speed
    end

    def calcNewY
        @y + Math.sin((@angle - 90) * (Math::PI / 180)) * @speed
    end

    def fly
        @x = calcNewX
        @y = calcNewY
    end

    def draw(offsetX, offsetY)
        @@LOADED_IMAGES[@spriteName].draw_rot(@x + offsetX, @y + offsetY - 20, @z, @angle)
    end
end
