require_relative 'AbstractBeing.rb'
require_relative 'Weapons/Weapon.rb'
require_relative 'Weapons/Pistol.rb'
require_relative 'Weapons/Shotgun.rb'
require_relative 'Weapons/Sniperrifle.rb'
require_relative 'Weapons/SMG.rb'

class Player < AbstractBeing
    attr_accessor :keyW
    attr_accessor :keyA
    attr_accessor :keyS
    attr_accessor :keyD
    attr_accessor :angle
    attr_accessor :crosshair

    def initialize
        super
        loadSprite('assets/PlayerSpriteSheet.bmp')
        @crosshair = Crosshair.new
        @keyW = 0
        @keyA = 0
        @keyS = 0
        @keyD = 0
        @weapon = SMG.new(self)
    end

    def	update(focus_x, focus_y, offsetX, offsetY)
        focus_y -= offsetY
        focus_x -= offsetX
        super(focus_x, focus_y)
        @crosshair.update(focus_x, focus_y)
        @keyW = Gosu.button_down?(Gosu::KbW) ? 1 : 0
        @keyS = Gosu.button_down?(Gosu::KbS) ? 1 : 0
        @keyA = Gosu.button_down?(Gosu::KbA) ? 1 : 0
        @keyD = Gosu.button_down?(Gosu::KbD) ? 1 : 0

        unless @weapon.nil?
            @weapon.update(@x, @y, @angle)
            @weapon.triggered = Gosu.button_down?(Gosu::MsLeft) || Gosu.button_down?(Gosu::KbSpace)
        end
    end

    def calcNewX
        a = Math.sqrt((((@keyS - @keyW) * @speed)**2) / 2)
        a = (a == 0) ? @speed : a
        @x + (@keyD - @keyA) * a
    end

    def calcNewY
        b = Math.sqrt((((@keyD - @keyA) * @speed)**2) / 2)
        b = (b == 0) ? @speed : b
        @y + (@keyS - @keyW) * b
    end

    def move
        @x = calcNewX
        @y = calcNewY
    end

    def draw(offsetX, offsetY)
        super
        @crosshair.draw(offsetX, offsetY)
    end
end
