Solver = Object:extend()

function Solver:new(ui)
	self.N_t = 10
	self.N_x = 10
	self.rho = 19000 -- [kg/m3] density
	self.C_p = 0.129*1e3 -- [J/kg.K] heat capacity
	self.k = 315 --[W/m.K] thermal conductivity
	self.dt = 1e-3 -- [s] time step
	self.dx = 1e-3/2 -- [m] space step
	self.T_0 = 300 -- [K] initial temperature
	self.T_bound = 1000 -- [K] initial temperature
	self.points = {}

	ui.graph = {}
	ui.graph[0] = Graph(Vector(150,20), Vector(600,600), Vector(0, 5),Vector(0,1000))
	ui.graph[0].xlabel = 'x [mm]'
	ui.graph[0].ylabel = 'T [K]'
end

function Solver:update()
end


function Solver:compute()
	print('Solver compute')

	local kappa = self.k/(self.rho*self.C_p) -- diffusion coefficient

	self.T = {} -- [K] temperature
	self.x = {} -- [m] space mesh
	self.t = {} -- [m] time mesh
	
	-- initialize self.t
	for n = 1, self.N_t do
		table.insert(self.t, (n-1)*self.dt)
	end
	-- initialize self.x
	for i = 1, self.N_x do
		table.insert(self.x, (i-1)*self.dx)
	end
	-- initialize self.T
	for n = 1, self.N_t do
		table.insert(self.T, {})
		for i = 1, self.N_x do
			if i == 1 or i == self.N_x then
				table.insert(self.T[n], self.T_bound)
			else	
				table.insert(self.T[n], self.T_0)
			end
		end
	end

	for n = 2, self.N_t do
		for i = 2, self.N_x-1 do
			-- local T_new = self.T[n-1][i] 
			local T_new = self.T[n-1][i] + self.dt*kappa*(self.T[n-1][i+1]-2*self.T[n-1][i]+self.T[n-1][i-1])/self.dx^2
			self.T[n][i] = T_new
		end
		-- display initial  vector
		print('n = ' .. n)
		-- print(#self.T[n])
		for i = 1, #self.T[n] do
			print('i = ' .. i .. '; T = '.. self.T[n][i])
		end
	end
	for i = 1, #self.x do
		table.insert(self.points, Vector(self.x[i]*1e3, self.T[9][i]))
	end
end

function Solver:reset()
	print('Solver reset')
	self.T = {{}} -- [K] temperature
	self.x = {} -- [m] space mesh
	self.t = {} -- [m] time mesh
	self.points = {}
end

function Solver:draw(ui)
	if #solver.points > 0 then
		ui.graph[0]:plot(self.points, white)
	end
end