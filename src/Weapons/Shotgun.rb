require_relative 'Weapon.rb'

class Shotgun < Weapon

    def initialize(being)
        super
        @damage = 1
        @delay = 50
        @projectileDuration = 65
        @name = "Shotgun"
		@weapontime = 900
        loadSound('assets/shotgun.wav')
    end

    def getProjectiles
        projectiles = []
        if @triggered && @cooldown == 0
            15.times do
                projectile = DefaultProjectile.new(@x, @y, @angle + rand(30) -15 , @projectileSpeed, rand(@projectileDuration), @damage, @being)
                projectile.pierce = true
                projectile.durability = 2
                projectiles << projectile
            end
            @cooldown = @delay
        end
        projectiles
    end
end
