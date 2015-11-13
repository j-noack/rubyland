require './src/AbstractBeing.rb'

class Player < AbstractBeing

	attr_accessor :keyW
	attr_accessor :keyA
	attr_accessor :keyS
	attr_accessor :keyD

    def initialize
        super
        @spriteImage = Gosu::Image.new("assets/player_sprite.bmp")
		@keyW = 0
		@keyA = 0
		@keyS = 0
		@keyD = 0

    def move
      @x += (@keyD - @keyA) - (1 - Math.sqrt((((@keyS - @keyW) * @speed)**2)/2))
      @y += (@keyS - @keyW) - (1 - Math.sqrt((((@keyD - @keyA) * @speed)**2)/2))
	
	print "Pressed Keys"
	print  Gosu::button_down?(Gosu::KbW)
	
    end

	def	update
		@keyW = Gosu::button_down?(Gosu::KbW) ? 1 : 0
		@keyS = Gosu::button_down?(Gosu::KbS) ? 1 : 0
        @keyA = Gosu::button_down?(Gosu::KbA) ? 1 : 0
		@keyD = Gosu::button_down?(Gosu::KbD) ? 1 : 0
		move
	end
	
    # angle = 0, center_x = 0.5, center_y = 0.5, scale_x = 1, scale_y = 1, color = 0xff_ffffff, mode = :default)
    def draw
      @spriteImage.draw_rot(@x, @y, @z, angle=0.0)
    end

end
