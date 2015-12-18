require_relative 'Weapon.rb'

class Pistol < Weapon

    def initialize(being)
        super
        @name = "Pistol"
		@weapontime = -1
        @damage = 4
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
