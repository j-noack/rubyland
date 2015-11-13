require_relative 'Drawable.rb'
require_relative 'Player.rb'
require_relative 'EnemyGenerator.rb'

class Map < Drawable

    attr_accessor :player
    attr_accessor :enemies

    def initialize(width, height)
        super()

        @width = width
        @height = height
        @player = Player.new
        @player.x = width / 2
        @player.y = height / 2

        @enemyGenerator = EnemyGenerator.new(@player)
        @enemies = @enemyGenerator.generate

        @backgroundImage = Gosu::Image.new("assets/boxhead.jpg")
    end

    def update
      @enemies.each do |enemy|
        enemy.update
      end
    end

    def draw(font)
        @backgroundImage.draw(@x, @y, @z)

        @enemies.each do |enemy|
          enemy.draw
        end

        @player.draw
    end

end
