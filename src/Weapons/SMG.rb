require_relative 'Weapon.rb'


class SMG < Weapon

    def initialize(being)
        super
        @damage = 1
        @delay = 5
        @projectileDuration = 40
        @projectileSpeed = 5
        @name = "SMG"
    end

    def fireProjectiles
        projectiles = []
        projectiles << Projectile.new(@x, @y, @angle, @projectileSpeed, @projectileDuration, @damage, @being)
        projectiles
    end

end
