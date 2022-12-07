Object = require "lib/classic"
Vector = require "lib/hump.vector"
Timer = require "lib/hump.timer"
utf8 = require("utf8")
require "ui/ui"
require "ui/slidebar"
require "ui/slidebutton"
require "ui/button"
require "ui/textbox"
require "ui/graph"
require "solver"

timer = Timer.new()
devMode = false
love.window.setTitle("Finite differences")
love.graphics.setDefaultFilter('nearest','nearest')
love.window.setMode(800, 700)
love.graphics.setBackgroundColor(31/255, 36/255, 48/255)
CMU_serif = love.graphics.newFont("fonts/computer-modern/cmunrm.ttf", 15)
CMU_serif_italic = love.graphics.newFont("fonts/computer-modern/cmunci.ttf", 35)
CMU_typewriter = love.graphics.newFont("fonts/computer-modern/cmuntb.ttf", 15)
pink = {228/255, 167/255, 239/255, 1}
green = {80/255, 250/255, 123/255, 1}
greeny = {80/255, 250/255, 123/255, 1}
white = {1, 1, 1, 1}
blue = {3/255, 236/255, 252/255}
yellow = {251/255, 255/255, 0/255}


function love.load()
	UI = Ui(CMU_typewriter)
	solver = Solver(UI)
end

function love.update(dt)
	UI:update()
end

function love.draw()
	solver:draw(UI)
	UI:draw()
end

