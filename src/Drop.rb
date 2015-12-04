require_relative 'Drawable.rb'

class Drop < Drawable
    attr_accessor :weapon

    def initialize
        super()
        @weapon = nil
        loadSprite('assets/Projectile.bmp')
    end

    def update
    end

    def draw

    end

end
