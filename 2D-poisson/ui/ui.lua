Ui = Object:extend()

require "ui/slidebar"
require "ui/slidebutton"
require "ui/button"
require "ui/textbox"
require "ui/graph"
require "ui/surface"

function Ui:new()
	self.font = love.graphics.newFont("fonts/computer-modern/cmuntb.ttf", 15)

	-- buttons
	self.button = {}
	self.button[0] = Button(20,600,100,30,1,'Compute',self.font)
	self.button[0].func = function()
		solver:compute()
	end

	self.button[1] = Button(20,645,100,30,2,'Reset',self.font)
	self.button[1].func = function()
		solver:reset()
	end

	self.button[2] = Button(window_width-30,0,30,30,2,'X',self.font)
	self.button[2].func = function()
		love.event.quit()
	end

	self.button[3] = Button(140,600,100,30,2,'Mesh',self.font)
	self.button[3].func = function()
		solver.mesh = true
	end

	-- textboxes
	self.textbox = {}
end


function Ui:update()
	-- buttons
	for i = 0, #self.button do 
		self.button[i]:update()
	end

	-- graphes
	for i = 0, #self.graph do 
		-- things that may be updated in graphes (size, position, scale)
	end

	-- surface
	for i = 0, #self.surface do 
		-- things that may be updated in surfaces (size, position, scale)
	end
end


function Ui:draw()
	-- buttons
	for i = 0, #self.button do -- draw menu buttons
		self.button[i]:draw()
	end

	-- graphes
	for i = 0, #self.graph do 
		self.graph[i]:draw()
		
		if #solver.points > 0 then
			self.graph[i]:plot(solver.points, white)
		end
	end

	-- graphes
	for i = 0, #self.surface do 
		self.surface[i]:draw()
		
		if solver.mesh == true then
			self.surface[i]:mesh(solver.x, solver.y, solver.V)
		end
	end
end


