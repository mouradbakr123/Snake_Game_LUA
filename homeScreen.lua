local homeScreen = {}

local titleImg
local enterImg

------------------------------------------------------------------------------------------
function homeScreen.load()
    titleImg = love.graphics.newImage("assets/HomePage_Snake.png")
    enterImg = love.graphics.newImage("assets/PressStartButten_Snake.png")
end

------------------------------------------------------------------------------------------
function homeScreen.draw(Grid, Snake, Food)

    Grid.draw()
    Snake.draw()
    Food.draw()

    -- dark overlay
    love.graphics.setColor(0, 0, 0, 0.5)
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())

    love.graphics.setColor(1, 1, 1)

    local sw = love.graphics.getWidth()

    -- TITLE
    love.graphics.draw(
        titleImg,
        sw / 2,
        240,
        0,
        5, 5,
        titleImg:getWidth() / 2,
        titleImg:getHeight() / 2
    )

    -- PRESS START
    love.graphics.draw(
        enterImg,
        sw / 2,
        260,
        0,
        3, 3,
        enterImg:getWidth() / 2,
        enterImg:getHeight() / 2
    )

    love.graphics.setColor(1, 1, 1)
end

------------------------------------------------------------------------------------------
return homeScreen