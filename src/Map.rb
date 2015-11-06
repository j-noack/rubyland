require './src/Drawable.rb'
require './src/Player.rb'
require './EnemyGenerator.rb'
class Map < Drawable

    attr_accessor :player
    attr_accessor :enemies

    def initialize(width, height)
        super()

        @width = width
        @height = height
        @player = Player.new
        @enemyGenerator = EnemyGenerator.new

        @enemies = @enemyGenerator.generate
        @backgroundImage = Gosu::Image.new("boxhead.jpg")
    end

    def update
      @enemies.each |enemy| do
        enemy.update
      end
    end

    def draw
        @backgroundImage.draw(@x, @y, @z)
        @enemies.each |enemy| do
          enemy.draw
        end
    end

end
