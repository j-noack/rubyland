require_relative '../Weapon.rb'

class Pistol < Weapon

    def initialize(being)
        super
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
