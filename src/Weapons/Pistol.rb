require_relative 'Weapon.rb'

class Pistol < Weapon

    def initialize(being)
        super
        @name = "Pistol"
		@weapontime = -1
    end

    def fireProjectiles
        projectiles = []
        projectiles << Projectile.new(@x, @y, @angle, @projectileSpeed, @projectileDuration, @damage, @being)
        projectiles
    end

end
