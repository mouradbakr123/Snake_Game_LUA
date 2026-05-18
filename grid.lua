local Grid = {}

Grid.tiles = {}

Grid.width = 20
Grid.height = 15

Grid.cellSize = 32
Grid.offsetX = 0
Grid.offsetY = 0

local tileImgs = {}

------------------------------------------------------------------------------------------------------------------------------------------------------------
-- LOAD IMAGES
function Grid.load()

    tileImgs = {
        love.graphics.newImage("assets/Grind_one.png"),
        love.graphics.newImage("assets/Grind_two.png"),
        love.graphics.newImage("assets/Grind_three.png"),
        love.graphics.newImage("assets/Grind_four.png"),
        love.graphics.newImage("assets/Grind_five.png"),
    }
end

------------------------------------------------------------------------------------------------------------------------------------------------------------
-- RESIZE GRID
function Grid.resize()

    local sw = love.graphics.getWidth()
    local sh = love.graphics.getHeight()

    Grid.cellSize = math.min(sw / Grid.width, sh / Grid.height)

    Grid.offsetX = (sw - Grid.width * Grid.cellSize) / 2
    Grid.offsetY = (sh - Grid.height * Grid.cellSize) / 2
end

------------------------------------------------------------------------------------------------------------------------------------------------------------
-- GENERATE RANDOM TILE MAP
function Grid.generateTiles()

    Grid.tiles = {}

    for x = 0, Grid.width - 1 do
        Grid.tiles[x] = {}

        for y = 0, Grid.height - 1 do
            Grid.tiles[x][y] = math.random(1, #tileImgs)
        end
    end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------
-- DRAW GRID
function Grid.draw()

    for x = 0, Grid.width - 1 do
        for y = 0, Grid.height - 1 do

            local id = Grid.tiles[x][y]
            local img = tileImgs[id]

            love.graphics.setColor(1, 1, 1)

            love.graphics.draw(
                img,
                Grid.offsetX + x * Grid.cellSize,
                Grid.offsetY + y * Grid.cellSize,
                0,
                Grid.cellSize / img:getWidth(),
                Grid.cellSize / img:getHeight()
            )
        end
    end
end

return Grid