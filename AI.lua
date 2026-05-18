local AI = {}

local Snake = require("snake")
local Food = require("food")
local Grid = require("grid")

------------------------------------------------------------------------------------------
local function hitsBody(x, y)
    for i = 2, #Snake.body do
        local p = Snake.body[i]
        if p.x == x and p.y == y then
            return true
        end
    end
    return false
end

local function hitsWall(x, y)
    return x < 0 or x >= Grid.width or y < 0 or y >= Grid.height
end

------------------------------------------------------------------------------------------
function AI.update()

    local head = Snake.body[1]
    if not head or #Food.items == 0 then return end

    -- find closest food
    local target = Food.items[1]
    local bestDist = math.huge

    for _, f in ipairs(Food.items) do
        local d = math.abs(f.x - head.x) + math.abs(f.y - head.y)
        if d < bestDist then
            bestDist = d
            target = f
        end
    end

    local dx = target.x - head.x
    local dy = target.y - head.y

    local dirs = {}

    if math.abs(dx) > math.abs(dy) then
        if dx > 0 then table.insert(dirs, {x=1,y=0}) else table.insert(dirs, {x=-1,y=0}) end
        if dy > 0 then table.insert(dirs, {x=0,y=1}) else table.insert(dirs, {x=0,y=-1}) end
    else
        if dy > 0 then table.insert(dirs, {x=0,y=1}) else table.insert(dirs, {x=0,y=-1}) end
        if dx > 0 then table.insert(dirs, {x=1,y=0}) else table.insert(dirs, {x=-1,y=0}) end
    end

    table.insert(dirs, {x=1,y=0})
    table.insert(dirs, {x=-1,y=0})
    table.insert(dirs, {x=0,y=1})
    table.insert(dirs, {x=0,y=-1})

    for _, d in ipairs(dirs) do

        if not (d.x == -Snake.dir.x and d.y == -Snake.dir.y) then

            local nx = head.x + d.x
            local ny = head.y + d.y

            if not hitsWall(nx, ny) and not hitsBody(nx, ny) then
                Snake.dir = d
                return
            end
        end
    end
end

return AI