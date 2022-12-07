Surface = Object:extend()

function Surface:new(position, dimension, x_scale, y_scale)
	-- graph dimensions
	self.position = position
	self.dimension = dimension
	self.x_scale = x_scale
	self.y_scale = y_scale
	self.x_unit2pixels = (self.x_scale.y-self.x_scale.x) / self.dimension.x -- [unit/pixel]
	self.y_unit2pixels = (self.y_scale.y-self.y_scale.x) / self.dimension.y -- [unit/pixel]

	local x_0 = self.position.x - self.x_scale.x/self.x_unit2pixels
	local y_0 = self.position.y + self.y_scale.y/self.y_unit2pixels
	self.origin = Vector(x_0, y_0)
	self.xlabel = ''
	self.ylabel = ''
	self.cross = false
	self.label_fontsize = 35
	self.ticks_fontsize = 15
	self.font_label = love.graphics.newFont("fonts/computer-modern/cmunci.ttf", self.label_fontsize)
	self.font_ticks = love.graphics.newFont("fonts/computer-modern/cmunci.ttf", self.ticks_fontsize)
end

function Surface:update()
	
end

function Surface:draw()
	local cross_size = 20
	local tic_size = 20
	local tic_n = 5
	local tic_x = self.position.x
	local tic_y = self.position.y+self.dimension.y
	local tic_step = self.dimension.y/(tic_n-1)
	local label = self.x_scale.x

	-- graph frame
	love.graphics.setColor(1, 1, 1)
	love.graphics.rectangle('line', self.position.x, self.position.y, self.dimension.x, self.dimension.y)
	if self.cross then
		if self.origin.x > self.position.x or 
		   self.origin.x < self.position.x+self.dimension.x then
			if self.origin.y > self.y_scale.y/self.y_unit2pixels or
			   self.origin.y < self.y_scale.y/self.y_unit2pixels then
				love.graphics.line(self.origin.x-cross_size/2,self.origin.y,self.origin.x+cross_size/2,self.origin.y)
				love.graphics.line(self.origin.x,self.origin.y-cross_size/2,self.origin.x,self.origin.y+cross_size/2)
			end
		end
	end
	-- xticks
	for i = 1,tic_n do
		
		love.graphics.line(tic_x,tic_y,tic_x,tic_y-tic_size)
		-- tick label
		love.graphics.printf(tostring(label),self.font_ticks,tic_x-15,tic_y+5,30,"center",0,1,1)

		tic_x = tic_x + tic_step
		label = label + tic_step*self.x_unit2pixels
	end

	local xlabel_x = self.position.x+0.5*self.dimension.x-math.ceil(#self.xlabel*self.label_fontsize/2)
	local xlabel_y = self.position.y+self.dimension.y+20
	love.graphics.printf(self.xlabel,self.font_label,xlabel_x,xlabel_y,200,"center",0,1,1)

	-- yticks
	local label = self.y_scale.x
	for i = 1,tic_n do
		
		love.graphics.line(self.position.x,tic_y,self.position.x + tic_size,tic_y)
		-- tick label
		love.graphics.printf(tostring(label),self.font_ticks,self.position.x-30,tic_y-10,30,"center",0,1,1)
		tic_y = tic_y - tic_step
		label = label + tic_step*self.y_unit2pixels
	end

	love.graphics.printf(self.ylabel,self.font_label,self.position.x-120,self.position.y+0.5*self.dimension.y-20,90,"center",0,1,1)

	love.graphics.setColor(1, 1, 1)
end

function Surface:plot(points, color)

end

function Surface:mesh(x,y,V)
	if x ~= nil and y ~= nil then
		local min_color = {0, 157/255, 255/255}
		local max_color = {255/255, 0, 25/255}

		local min_V = 0
		local max_V = 10

		for i = 1, #x do
			local cell_x = self.origin.x + x[i] * 1e3 / self.x_unit2pixels
			if i == 1 then
				dx = (x[i+1]-x[i]) * 1e3 / self.x_unit2pixels
			else
				dx = (x[i]-x[i-1]) * 1e3 / self.x_unit2pixels
			end

			for j = 1, #y do
				local cell_y = self.origin.y - y[j] * 1e3 / self.y_unit2pixels
				if j == 1 then
					dy = (y[j+1]-y[j]) * 1e3 / self.x_unit2pixels
				else
					dy = (y[j]-y[j-1]) * 1e3 / self.x_unit2pixels
				end
				-- alpha = math.abs(V[i][j])/20
				local r = min_color[1] + V[i][j]/(max_V-min_V) * (max_color[1]-min_color[1])
				local g = min_color[2] + V[i][j]/(max_V-min_V) * (max_color[2]-min_color[2])
				local b = min_color[3] + V[i][j]/(max_V-min_V) * (max_color[3]-min_color[3])

				love.graphics.setColor(r, g, b, 1)
				love.graphics.rectangle('fill', cell_x, cell_y-dy, dx, dy)
				love.graphics.setColor(1, 1, 1, alpha)
			end
		end
	end
end