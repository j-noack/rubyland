require_relative 'Drawable.rb'

class Highscore < Drawable
    attr_accessor :score

    def initialize
        super
        @score = 0
    end

    def update
    end

    def draw(font)
        font.draw("Highscore: #{@score}", 5, 5, 999)
    end
end
