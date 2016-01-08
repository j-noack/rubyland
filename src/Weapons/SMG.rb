require_relative 'Weapon.rb'


class SMG < Weapon

    def initialize(being)
        super
        @damage = 1
        @delay = 5
        @projectileDuration = 40
        @projectileSpeed = 5
        @name = "SMG"
		@weapontime = 900
        loadSound('assets/smg.wav')
    end

    def getProjectiles
        projectiles = []
        if @triggered && @cooldown == 0
            projectiles << DefaultProjectile.new(@x, @y, @angle - 5 + rand(10), @projectileSpeed, @projectileDuration, @damage, @being)
            @cooldown = @delay
        end
        projectiles
    end

end
