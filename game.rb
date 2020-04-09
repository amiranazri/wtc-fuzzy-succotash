require 'gosu'
require_relative 'defstruct' #defstruct allows for default values whereas most ruby structs don't. 

GameState = DefStruct.new{{
	scroll_x: 0,
}}

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
	def button_down(button) #checks if the button id is pressed.  
		close if button == Gosu::KbEscape
	end

	#update and then draw below, both at *est.* 60fps
	def update
		@state.scroll_x += 3
		if	@state.scroll_x > @images[:foreground].width
			@state.scroll_x = 0
		end
	end

	def draw
		@images[:background].draw(0,0,0)
		@images[:foreground].draw(-@state.scroll_x,0,0)
		@images[:foreground].draw(-@state.scroll_x + @images[:foreground].width,0,0)
		@images[:fuzzy].draw(0,0,0)
	end
end

window = GameWindow.new(320, 480, false)
window.show
