local Grid = {}

Grid.width = 20
Grid.height = 15

Grid.cellSize = 32
Grid.offsetX = 0
Grid.offsetY = 0
---------------------------------------------------------------------------------------------------
-- functions

-- resize the screen based of the screen width and height
function Grid.resize()

    local sw = love.graphics.getWidth()
    local sh = love.graphics.getHeight()

    Grid.cellSize = math.min(sw / Grid.width, sh / Grid.height)

    Grid.offsetX = (sw - Grid.width * Grid.cellSize) / 2
    Grid.offsetY = (sh - Grid.height * Grid.cellSize) / 2

end

function Grid.draw()

    for x = 0, Grid.width - 1 do
        for y = 0, Grid.height - 1 do

            love.graphics.rectangle(
                "line",
                Grid.offsetX + x * Grid.cellSize,
                Grid.offsetY + y * Grid.cellSize,
                Grid.cellSize,
                Grid.cellSize
            )

        end
    end

end

return Grid