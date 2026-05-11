local Grid = require("grid")
local Snake = require("snake")
local Input = require("input")
local Food = require("food")
------------------------------------------------------------------------------------------
-- this is the main script
-- here all the other scripts get called

-- load the game
function love.load()
    Grid.resize()
    Snake.reset()
    Food.spawn()
end

function love.resize()
    Grid.resize()
end

-- updates the game live
function love.update(dt)
    Snake.update(dt)
    Food.checkEat()
end

function love.draw()
    Grid.draw()
    Snake.draw()
    Food.draw()
end

function love.keypressed(key)
    Input.keypressed(key)
end