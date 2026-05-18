local Grid = require("grid")
local Snake = require("snake")
local Input = require("input")
local Food = require("food")
local AI = require("ai")
local homeScreen = require("homeScreen")
local ScoreSystem = require("scoreSystem")

local gameState = "home"

------------------------------------------------------------------------------------------
function love.load()

    love.graphics.setDefaultFilter("nearest", "nearest")

    math.randomseed(os.time())
    math.random(); math.random(); math.random()

    Grid.load()
    Grid.resize()
    Grid.generateTiles()
    homeScreen.load()
    Snake.reset()
    Food.spawn()
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

    local eatenType = Food.checkEat()
    local isDespawn = Food.update(dt)

    if eatenType then
        ScoreSystem.AddBaseScore(eatenType)
        ScoreSystem.AddCombo(true)
    elseif isDespawn == "despawn" then
        ScoreSystem.AddCombo(false)
    end
end

------------------------------------------------------------------------------------------
function love.draw()

    if gameState == "home" then
        homeScreen.draw(Grid, Snake, Food)
    elseif gameState == "game" then
        Grid.draw()
        Snake.draw()
        Food.draw()
        ScoreSystem.Display()
    end
end
------------------------------------------------------------------------------------------
function love.keypressed(key)

    if gameState == "home" then

        if key == "return" then
            gameState = "game"
            Food.items = {}
            ScoreSystem.enabled = true
            Snake.reset()
            Food.spawn()
        end

    else
        Input.keypressed(key)
    end

end