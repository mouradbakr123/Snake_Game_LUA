local Grid = require("grid")
local Snake = require("snake")

local Food = {}

Food.x = 10
Food.y = 10
Food.type = "normal"
------------------------------------------------------------------------------------------------
-- functions

-- spawn food at random grid position
function Food.spawn()

    Food.x = math.random(0, Grid.width - 1)
    Food.y = math.random(0, Grid.height - 1)

    Food.type = "normal"

end

-- check if snake ate food
function Food.checkEat()

    local head = Snake.body[1]

    if head.x == Food.x and head.y == Food.y then
        Snake.eat()
        Food.spawn()
    end

end

function Food.draw()

    love.graphics.setColor(1, 0, 0)

    love.graphics.rectangle(
        "fill",
        Grid.offsetX + Food.x * Grid.cellSize,
        Grid.offsetY + Food.y * Grid.cellSize,
        Grid.cellSize,
        Grid.cellSize
    )

    love.graphics.setColor(1, 1, 1)

end

return Food