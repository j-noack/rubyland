require_relative 'Weapon.rb'

class GlobberWeapon < Weapon

    def initialize(being)
        super
        @name = "GlobWeapon"
		@weapontime = -1
        @damage = 20
        @delay = 360
        @projectileDuration = 80
        @projectileSpeed = 2
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
