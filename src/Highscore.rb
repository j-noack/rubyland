require_relative 'Drawable.rb'

class Highscore < Drawable

    attr_accessor :score

    def initialize
        super
        @score = 0

        @scoreBonus = 10
        @bonusIntervall = 60
        @intervallCount = 0
    end

    def update
      @intervallCount += 1
      if @bonusIntervall == @intervallCount
        @intervallCount = 0
        @score += @scoreBonus
      end
    end

    def draw(font)
      font.draw("Highscore: #{@score}", 5, 5, 999)
    end
end
