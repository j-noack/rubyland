require_relative 'Drawable.rb'

class AbstractBeing < Drawable

    attr_accessor :speed
    attr_accessor :sprite
    attr_accessor :hp
    attr_accessor :weapon

    def initialize
        super
        @z = 5
        @speed = 5
        @sprite = ""
        @hp = 1
        @weapon = nil
    end

    def damage
        return 5
    end


end
