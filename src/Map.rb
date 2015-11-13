require_relative 'Drawable.rb'
require_relative 'Player.rb'
require_relative 'EnemyGenerator.rb'
require_relative 'Crosshair.rb'

class Map < Drawable

    attr_accessor :player
    attr_accessor :enemies
    attr_accessor :borderWidth

    def initialize(width, height, borderWidth)
        super()

        @width = width
        @height = height
        @borderWidth = borderWidth
        @player = Player.new
        @player.x = width / 2
        @player.y = height / 2

        @enemyGenerator = EnemyGenerator.new(self, @player)
        @enemies = @enemyGenerator.generate

        @collisionManager = CollisionManager.new(self)
        @backgroundImage = Gosu::Image.new("assets/Rubyland.bmp")
    end

    def update(mouse_x, mouse_y)
      @player.update(mouse_x, mouse_y)
      if @collisionManager.canPlayerMove?
        @player.move
      end

      @enemies.each do |enemy|
        enemy.update
      end
    end

    def draw(font)
        @backgroundImage.draw(@x, @y, @z)
        @enemies.each do |enemy|
          enemy.draw(self.x, self.y)
        end

        @player.draw(self.x, self.y)
    end

end
