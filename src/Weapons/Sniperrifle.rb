require_relative '../Weapon.rb'

class Snippy < Weapon

    def initialize(being)
        super
        @projectileSpeed = 15
        @projectileDuration = 200
        @delay = 60
        @damage = 100
    end

    def getProjectiles#(@x, @y, @angle,@being)
        projectiles = []
        if @triggered && @cooldown == 0
            projectile = Projectile.new(@x, @y, @angle, @projectileSpeed, @projectileDuration, @damage, @being)
            projectile.pierce = true
            projectiles << projectile
            @cooldown = @delay
        end
        return projectiles
    end

end
