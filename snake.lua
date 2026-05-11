local Snake = {}
local Grid = require("grid")

Snake.body = {}

Snake.dir = { x = 1, y = 0 }

Snake.timer = 0
Snake.speedMult = 1
Snake.speedTimer = 0
Snake.speed = 0.15

Snake.grow = 0

---------------------------------------------------------------------------------------------
-- reset function
function Snake.reset()

    Snake.body = {
        { x = 5, y = 5 },
        { x = 4, y = 5 },
        { x = 3, y = 5 }
    }

    Snake.dir = { x = 1, y = 0 }
    Snake.timer = 0
    Snake.grow = 0
    Snake.speedTimer = 0
    Snake.speedMult = 1

end

---------------------------------------------------------------------------------------------
-- movement
function Snake.update(dt)

    Snake.timer = Snake.timer + dt

    -- speed boost system
    if Snake.speedTimer > 0 then
        Snake.speedTimer = math.max(0, Snake.speedTimer - dt)
        Snake.speedMult = 1.5
    else
        Snake.speedMult = 1
    end

    local length = #Snake.body
    local baseSpeed = 0.15

    Snake.speed = math.max(0.05, (baseSpeed - (length * 0.002))) / Snake.speedMult

    if Snake.timer < Snake.speed then return end
    Snake.timer = 0

    local head = Snake.body[1]

    -- new head position
    local newHead = {
        x = head.x + Snake.dir.x,
        y = head.y + Snake.dir.y
    }

    table.insert(Snake.body, 1, newHead)

    -- remove tail unless growing
    if Snake.grow > 0 then
        Snake.grow = Snake.grow - 1
    else
        table.remove(Snake.body)
    end

    -- self collision
    for i = 2, #Snake.body do
        local part = Snake.body[i]

        if newHead.x == part.x and newHead.y == part.y then
            Snake.reset()
            return
        end
    end

    Snake.checkDeath()
end

---------------------------------------------------------------------------------------------
-- eating
function Snake.eat(score)
    Snake.grow = Snake.grow + score
end

---------------------------------------------------------------------------------------------
-- wall collision
function Snake.checkDeath()

    local head = Snake.body[1]

    if head.x < 0 or head.x >= Grid.width
    or head.y < 0 or head.y >= Grid.height then
        Snake.reset()
    end

end

---------------------------------------------------------------------------------------------
-- draw
function Snake.draw()

    local len = #Snake.body

    for i, part in ipairs(Snake.body) do

        local t = i / len  -- 0 (head) → 1 (tail)

        local r, g, b

        if Snake.speedTimer > 0 then
            -- speed mode: cyan gradient
            r = 0.2 * (1 - t)
            g = 0.9 * (1 - t)
            b = 1
        else
            -- normal green gradient
            r = 0.2 * (1 - t)
            g = 0.8 * (1 - t) + 0.2
            b = 0.2 * (1 - t)
        end

        love.graphics.setColor(r, g, b)

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