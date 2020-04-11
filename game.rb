require 'gosu'
require_relative 'defstruct' #defstruct allows for default values whereas most ruby structs don't. 

#Fuzzy = Game Character (Dog)
GameState = DefStruct.new{{
	scroll_x: 0,
	fuzzy_y: 300,
	fuzzy_vel_y: 0, #Zero is the starting point on ground (not jumping, hence 0)
}}
#Gravity is essentially acceleration of fuzzy - measured by pixels/sˆ2 (sqrd)
GRAVITY = 50 

class GameWindow < Gosu::Window
	def initialize(*args)
		super
		@images = {
			background: Gosu::Image.new(self, 'images/background.png', false),
			foreground: Gosu::Image.new(self, 'images/foreground.png', true),
			fuzzy: Gosu::Image.new(self, 'images/bean/idle1.png', false),
		}
		@state = GameState.new
	end

	#instance variable to hold all the other variable values that'll keep fucking changing because yes. 
		@state = {

		}
	def button_down(button) #checks that the button id is pressed.  
		close if button == Gosu::KbEscape
	end

	#update and then draw below, both at *est.* 60fps
	def update
		@state.scroll_x += 3
		if	@state.scroll_x > @images[:foreground].width
			@state.scroll_x = 0
		end
		
		delay = update_interval / 1000.0
		@state.fuzzy_vel_y += GRAVITY * delay
		@state.fuzzy_y += @state.fuzzy_vel_y * delay
	end

	def draw
		@images[:background].draw(0,0,0)
		@images[:foreground].draw(-@state.scroll_x,0,0)
		@images[:foreground].draw(-@state.scroll_x + @images[:foreground].width,0,0)
		@images[:fuzzy].draw(20,@state.fuzzy_y,0)
	end
end

window = GameWindow.new(320, 480, false)
window.show