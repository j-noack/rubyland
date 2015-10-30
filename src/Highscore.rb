require './src/Drawable.rb'

class Highscore < Drawable

    attr_accessor :score

    def initialize
        super
        @score = 0
    end

end
