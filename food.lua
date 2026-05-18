local Grid = require("grid")
local Snake = require("snake")

local Food = {}
Food.items = {}

-- images
local Poison_apple_Img = love.graphics.newImage("assets/Skull_apple.png")
local Normal_apple_Img = love.graphics.newImage("assets/Normal_apple.png")
local Golden_apple_Img = love.graphics.newImage("assets/Golden_apple.png")
local Bonus_apple_Img = love.graphics.newImage("assets/Bonus_apple.png")
local Speed_apple_Img = love.graphics.newImage("assets/Speed_apple.png")

---------------------------------------------------------------------------------------------------------------------
-- food types
local foodTypes = {
    normal = {
        image = Normal_apple_Img,
        score = 1,
        weight = 70,
    },

    bonus = {
        image = Bonus_apple_Img,
        score = 3,
        weight = 25,
    },

    gold = {
        image = Golden_apple_Img,
        score = 5,
        weight = 5,
    },

    speed = {
        image = Speed_apple_Img,
        score = 2,
        weight = 15,
    },

    poison = {
        image = Poison_apple_Img,
        score = -2,
        weight = 20,
        -- no color (uses skull image instead)
    },
}

---------------------------------------------------------------------------------------------------------------------
-- pick weighted food type
function pickFoodType()
    local total = 0

    for _, data in pairs(foodTypes) do
        total = total + data.weight
    end

    local r = math.random() * total
    local sum = 0

    for name, data in pairs(foodTypes) do
        sum = sum + data.weight
        if r <= sum then
            return name
        end
    end

    return "normal"
end

---------------------------------------------------------------------------------------------------------------------
-- spawn food
function Food.spawn()
    local type = pickFoodType()

    table.insert(Food.items, {
        x = math.random(0, Grid.width - 1),
        y = math.random(0, Grid.height - 1),
        type = type,

        timer = 0,
        life = 7,

        blink = false,
        blinkTimer = 0
    })
end

---------------------------------------------------------------------------------------------------------------------
-- update (despawn + blink)
function Food.update(dt)

    for i = #Food.items, 1, -1 do
        local food = Food.items[i]

        food.timer = food.timer + dt

        -- blinking
        if food.life - food.timer < 1 then
            food.blinkTimer = food.blinkTimer + dt

            if food.blinkTimer > 0.2 then
                food.blink = not food.blink
                food.blinkTimer = 0
            end
        else
            food.blink = false
        end

        -- despawn
        if food.timer >= food.life then

            table.remove(Food.items, i)

            if #Food.items < 3 then
                Food.spawn()
            end

            return "despawn"
        end
    end

    return nil
end

---------------------------------------------------------------------------------------------------------------------
-- eating
function Food.checkEat()

    local head = Snake.body[1]

    for i = #Food.items, 1, -1 do

        local food = Food.items[i]
        local data = foodTypes[food.type]

        if head.x == food.x and head.y == food.y then

            -- score change
            Snake.eat(data.score)

            -- SPEED FOOD
            if food.type == "speed" then
                Snake.speedTimer = 2
            end

            -- POISON FOOD
            if food.type == "poison" then
                Snake.grow = math.max(0, Snake.grow - 3)
                Snake.speedTimer = 0
                Snake.timer = 0
            end

            table.remove(Food.items, i)

            if #Food.items < 3 then
                Food.spawn()
            end

            return food.type
        end
    end

    return nil
end

---------------------------------------------------------------------------------------------------------------------
-- draw
function Food.draw()

    for _, food in ipairs(Food.items) do
        local data = foodTypes[food.type]

        local alpha = 1
        if food.blink then
            alpha = 0.4
        end

        -- IMAGE FOOD (poison)
        if data.image then
            love.graphics.setColor(1, 1, 1, alpha)

            local iw, ih = data.image:getDimensions()

            love.graphics.draw(
                data.image,
                Grid.offsetX + food.x * Grid.cellSize,
                Grid.offsetY + food.y * Grid.cellSize,
                0,
                Grid.cellSize / iw,
                Grid.cellSize / ih
            )

        -- NORMAL FOOD
        else
            love.graphics.setColor(
                data.color[1],
                data.color[2],
                data.color[3],
                alpha
            )

            love.graphics.rectangle(
                "fill",
                Grid.offsetX + food.x * Grid.cellSize,
                Grid.offsetY + food.y * Grid.cellSize,
                Grid.cellSize,
                Grid.cellSize
            )
        end
    end

    love.graphics.setColor(1, 1, 1)
end

return Food