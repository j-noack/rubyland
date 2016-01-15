require_relative 'Weapon.rb'

class Pistol < Weapon

    def initialize(being)
        super
        @name = "Pistol"
		@weapontime = -1
        @damage = 2
        loadSound('assets/Bulletsound.wav')
    end

    def getProjectiles
        projectiles = []
        if @triggered && @cooldown == 0
            projectiles << DefaultProjectile.new(@x, @y, @angle, @projectileSpeed, @projectileDuration, @damage, @being)
            @cooldown = @delay
        end
        projectiles
    end

end
