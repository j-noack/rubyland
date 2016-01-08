require_relative '../Drawable.rb'
require_relative '../Projectile.rb'

class Weapon < Drawable
    @@LOADED_SOUNDS = {}

    attr_accessor :triggered
    attr_accessor :being
    attr_accessor :name
	attr_accessor :weapontime

    def initialize(being)
        super()
        @being = being
        @projectileSpeed = 5
        @projectileDuration = 200
        @delay = 15
        @cooldown = 0
        @triggered = false
        @damage = 1
        @name = "---"
        @soundName = ""
		@weapontime = 0
    end

    def loadSound(file)
        unless @@LOADED_SOUNDS.has_key?(file)
            @@LOADED_SOUNDS[file] = Gosu::Sample.new(file)
        end

        @soundName = file
    end

    # TODO: Waffe and gemalte position anpassen
    def update(playerX, playerY, playerAngle)
        @x = playerX
        @y = playerY
        @angle = playerAngle
        @cooldown -= 1 if @cooldown > 0
		@weapontime -= 1 if @weapontime > 0
    end

    def fire
        projectiles = getProjectiles

        unless projectiles.empty?
            if @@LOADED_SOUNDS.has_key?(@soundName)
                @@LOADED_SOUNDS[@soundName].play(0.55)
            end
        end

        projectiles
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
