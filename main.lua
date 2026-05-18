local Grid = require("grid")
local Snake = require("snake")
local Input = require("input")
local Food = require("food")
local AI = require("ai")
local homeScreen = require("homeScreen")

local gameState = "home"

------------------------------------------------------------------------------------------
function love.load()

    love.graphics.setDefaultFilter("nearest", "nearest")

    Grid.resize()
    Snake.reset()
    Food.spawn()
    homeScreen.load()
end

------------------------------------------------------------------------------------------
function love.resize()
    Grid.resize()
end

------------------------------------------------------------------------------------------
function love.update(dt)

    if gameState == "home" then
        AI.update()
    end

    Snake.update(dt)
    Food.update(dt)
    Food.checkEat()

end

------------------------------------------------------------------------------------------
function love.draw()

    if gameState == "home" then
        homeScreen.draw(Grid, Snake, Food)
    else
        Grid.draw()
        Snake.draw()
        Food.draw()
    end
end
------------------------------------------------------------------------------------------
function love.keypressed(key)

    if gameState == "home" then

        if key == "return" then
            gameState = "game"
            Snake.reset()
            Food.spawn()
        end

    else
        Input.keypressed(key)
    end

end