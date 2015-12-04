require_relative '../Weapon.rb'


class SMG < Weapon

    def initialize(being)
        super
        @damage = 1
        @delay = 5
        @projectileDuration = 40
        @projectileSpeed = 5
    end

    def getProjectiles#(@x, @y, @angle,@being)
        projectiles = []
        if @triggered && @cooldown == 0
            projectiles << Projectile.new(@x, @y, @angle, @projectileSpeed, @projectileDuration, @damage, @being)
            @cooldown = @delay
        end

        return projectiles
    end

end
