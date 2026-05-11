local Snake = require("snake")

local Input = {}

function Input.keypressed(key)

    if key == "up" and Snake.dir.y ~= 1 then
        Snake.dir = { x = 0, y = -1 }

    elseif key == "down" and Snake.dir.y ~= -1 then
        Snake.dir = { x = 0, y = 1 }

    elseif key == "left" and Snake.dir.x ~= 1 then
        Snake.dir = { x = -1, y = 0 }

    elseif key == "right" and Snake.dir.x ~= -1 then
        Snake.dir = { x = 1, y = 0 }
    end

end

return Input