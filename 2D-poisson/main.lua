Object = require "lib/classic"
Vector = require "lib/hump.vector"
Timer = require "lib/hump.timer"
utf8 = require("utf8")
require "ui/ui"
require "solver"

pink = {228/255, 167/255, 239/255, 1}
green = {80/255, 250/255, 123/255, 1}
greeny = {80/255, 250/255, 123/255, 1}
white = {1, 1, 1, 1}
blue = {3/255, 236/255, 252/255}
yellow = {251/255, 255/255, 0/255}

window_width = 1250
window_height = 700

timer = Timer.new()
devMode = false
love.window.setTitle("Finite differences")
love.graphics.setDefaultFilter('nearest','nearest')
love.window.setMode(window_width, window_height, {borderless=true})
love.graphics.setBackgroundColor(31/255, 36/255, 48/255)

function love.load()
	UI = Ui()
	solver = Solver(UI)
end

function love.update(dt)
	UI:update()
end

function love.draw()
	UI:draw()
end

