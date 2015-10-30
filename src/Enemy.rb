require './AbstractBeing.rb'

class Enemy < AbstractBeing

    attr_accessor :target

    def initialize
        super

        @target = nil
    end

end
