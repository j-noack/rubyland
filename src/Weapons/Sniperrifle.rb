require_relative 'Weapon.rb'

class Sniperrifle < Weapon

    def initialize(being)
        super
        @projectileSpeed = 15
        @projectileDuration = 200
        @delay = 60
        @damage = 4
        @name = "Sniperrifle"
		@weapontime = 900
        loadSound('assets/sniperrifle.wav')
    end

    def getProjectiles
        projectiles = []
        if @triggered && @cooldown == 0
            projectile = DefaultProjectile.new(@x, @y, @angle, @projectileSpeed, @projectileDuration, @damage, @being)
            projectile.pierce = true
            projectile.durability = 100
            projectiles << projectile
            @cooldown = @delay
        end
        projectiles
    end

end
