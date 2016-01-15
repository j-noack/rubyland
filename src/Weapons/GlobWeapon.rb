require_relative 'Weapon.rb'

class GlobberWeapon < Weapon

    def initialize(being)
        super
        @name = "GlobWeapon"
		@weapontime = -1
        @damage = 35
        @delay = 360
        @projectileDuration = 450
        @projectileSpeed = 2
        @cooldown = 200
    end

    def getProjectiles
        projectiles = []
        if @triggered && @cooldown == 0
            projectiles << BlobberProjectile.new(@x, @y, @angle, @projectileSpeed, @projectileDuration, @damage, @being)
            @cooldown = @delay
        end
        projectiles
    end

end
