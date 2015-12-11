require_relative 'Weapon.rb'

class Shotgun < Weapon

    def initialize(being)
        super
        @damage = 1
        @delay = 50
        @projectileDuration = 65
        @name = "Shotgun"
    end

    def fireProjectiles
        projectiles = []
        15.times do
            projectile = Projectile.new(@x, @y, @angle + rand(30) -15 , @projectileSpeed, rand(@projectileDuration), @damage, @being)
            projectile.pierce = true
            projectile.durability = 2
            projectiles << projectile
        end
        projectiles
    end
end
