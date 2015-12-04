require_relative '../Weapon.rb'

class Shotty < Weapon

    def initialize(being)
        super
        @damage = 1
        @delay = 50
        @projectileDuration = 65
    end

    def getProjectiles
        projectiles = []
        if @triggered && @cooldown == 0
            15.times do
                projectile = Projectile.new(@x, @y, @angle + rand(30), @projectileSpeed, rand(@projectileDuration), @damage, @being)
                projectile.pierce = true
                projectiles << projectile
            end
            @cooldown = @delay
        end
        return projectiles
    end

end
