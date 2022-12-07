Solver = Object:extend()

function Solver:new(ui)
	self.N_t = 5000
	self.N_x = 50
	self.N_y = 50
	self.dx = 1e-3/5 -- [m] space step
	self.dy = 1e-3/5 -- [m] space step
	self.points = {}

	self.V1 = 10 -- [V] boundary condition
	self.V2 = 10 -- [V] boundary condition

	ui.graph = {}
	ui.graph[0] = Graph(Vector(150,100), Vector(400,400), Vector(0, 10),Vector(-20,20))
	ui.graph[0].xlabel = 'x [mm]'
	ui.graph[0].ylabel = 'V [V]'
	ui.graph[0].cross = false

	ui.surface = {}
	ui.surface[0] = Surface(Vector(750,100), Vector(400,400), Vector(0, 10),Vector(0,10))
	ui.surface[0].xlabel = 'x [mm]'
	ui.surface[0].ylabel = 'y [mm]'

	self.mesh = false
end

function Solver:update()
end


function Solver:compute()
	self.V = {} -- [K] temperature
	self.x = {} -- [m] space mesh
	self.y = {} -- [m] time mesh
	local K = (self.dx^2*self.dy^2)/(2*(self.dx^2+self.dy^2))

	-- initialization
	for i = 1, self.N_x do
		table.insert(self.x, (i-1)*self.dx)
	end

	for i = 1, self.N_y do
		table.insert(self.y, (i-1)*self.dy)
	end
	
	for i = 1, self.N_x do
		table.insert(self.V, {})
		for j = 1, self.N_y do
			if j == 1 then
				table.insert(self.V[i], self.V1)
			elseif j == self.N_x then
				table.insert(self.V[i], self.V2)
			else	
				table.insert(self.V[i], 0)
			end
		end
	end

	-- computation loop
	for n = 2, self.N_t do
		for i = 2, self.N_x-1 do
			-- reset boundary condition
			if j == 1 then
				self.V[i][j] = self.V1
			elseif j == self.N_x then
				self.V[i][j] = self.V2
			end

			for j = 2, self.N_y-1 do
				local V_new = K*((self.V[i][j+1]+self.V[i][j-1])/self.dy^2 + (self.V[i+1][j]+self.V[i-1][j])/self.dx^2)
				self.V[i][j] = V_new
			end
		end
	end

	-- format data for display
	for i = 1, #self.x do
		table.insert(self.points, Vector(self.x[i]*1e3, self.V[40][i]))
	end
end

function Solver:reset()
	self.V = {{}} -- [K] temperature
	self.x = {} -- [m] space mesh
	self.y = {} -- [m] space mesh
	self.t = {} -- [m] time mesh
	self.points = {}
end