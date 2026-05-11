local Snake = {}
local Grid = require("grid")

Snake.body = {}

Snake.dir = { x = 1, y = 0 }

Snake.timer = 0
Snake.speed = 0.15

Snake.grow = 0
---------------------------------------------------------------------------------------------
--- functions

-- reset function
function Snake.reset() -- just put the player at the start for tetsing

    Snake.body = {
        { x = 5, y = 5 },
        { x = 4, y = 5 },
        { x = 3, y = 5 }
    }

    Snake.dir = { x = 1, y = 0 }
    Snake.timer = 0
    Snake.grow = 0

end

-- movement
function Snake.update(dt)

    Snake.timer = Snake.timer + dt
    local length = #Snake.body
    local baseSpeed = 0.15

    Snake.speed = math.max(0.05, baseSpeed - (length * 0.005))
    if Snake.timer < Snake.speed then return end
    Snake.timer = 0

    local head = Snake.body[1]

    -- new head position
    local newHead = {
        x = head.x + Snake.dir.x,
        y = head.y + Snake.dir.y
    }

    -- insert new head
    table.insert(Snake.body, 1, newHead)

    -- remove tail unless growing
    if Snake.grow > 0 then
        Snake.grow = Snake.grow - 1
    else
        table.remove(Snake.body)
    end

    for i = 2, #Snake.body do

    local part = Snake.body[i]
    -- resets if the snake hits its body
    if newHead.x == part.x and newHead.y == part.y then
        Snake.reset()
        return
    end

end
    Snake.checkDeath()
end

-- grow snake
function Snake.eat()
    Snake.grow = Snake.grow + 1
end

-- death (walls only for now)
function Snake.checkDeath()

    local head = Snake.body[1]

    if head.x < 0 or head.x >= 20 or head.y < 0 or head.y >= 15 then
        Snake.reset()
    end

end

-- draw snake
function Snake.draw()

    love.graphics.setColor(0, 1, 0)

    for i, part in ipairs(Snake.body) do

        love.graphics.rectangle(
            "fill",
            Grid.offsetX + part.x * Grid.cellSize,
            Grid.offsetY + part.y * Grid.cellSize,
            Grid.cellSize,
            Grid.cellSize
        )

    end

    love.graphics.setColor(1, 1, 1)

end

return Snake