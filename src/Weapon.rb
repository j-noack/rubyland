require_relative 'Drawable.rb'
require_relative 'Projectile.rb'

class Weapon < Drawable
    attr_accessor :triggered
    attr_accessor :being

    def initialize(being)
        super()
        @being = being
        @projectileSpeed = 5
        @projectileDuration = 200
        @delay = 15
        @cooldown = 0
        @triggered = false
        @damage = 1
    end

    # TODO: @LUKAS position anpassen
    def update(playerX, playerY, playerAngle)
        @x = playerX
        @y = playerY
        @angle = playerAngle
        @cooldown -= 1 if @cooldown > 0
    end

    def getProjectiles
        projectiles = []
        if @triggered && @cooldown == 0
            projectiles << Projectile.new(@x, @y, @angle, @projectileSpeed, @projectileDuration, @damage, @being)
            @cooldown = @delay
        end

        projectiles
    end
end
