
Ui = Object:extend()


function Ui:new(font)
	self.font = font

	-- buttons
	self.button = {}
	self.button[0] = Button(640,30,100,30,1,'Compute',font)
	self.button[0].func = function()
		solver:compute()
	end

	self.button[1] = Button(640,80,100,30,2,'Reset',font)
	self.button[1].func = function()
		solver:reset()
	end

	-- textboxes
	self.textbox = {}

	-- graphes
	-- self.graph = {}
	-- local size_graph = 10
	-- -- self.graph[0] = Graph(Vector(150,20), Vector(600,600), Vector(1, 20),Vector(200,2000))
	-- self.graph[0] = Graph(Vector(150,20), Vector(600,600), Vector(0, 5),Vector(0,1000))
	-- self.graph[0].xlabel = 'x [mm]'
	-- self.graph[0].ylabel = 'T [K]'
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
			self.graph[0]:plot(solver.points, white)
		end
	end
end


