local ScoreSystem = {}
ScoreSystem.enabled = true

local combo = 0
local score = 0
local baseScore = 0

-------------------------------------------------------------------------------------------------------------------------------
function ScoreSystem.reset()
    combo = 0
    score = 0
    baseScore = 0
end

-- Combo logic
function ScoreSystem.AddCombo(foodEaten)

    if not ScoreSystem.enabled then
        return
    end

    if foodEaten then
        combo = combo + 1
    else
        combo = 0
    end
end

function ScoreSystem.GetCombo()
    return combo
end

-- Score logic
function ScoreSystem.AddBaseScore(foodType)

    if not ScoreSystem.enabled then
        return
    end

    if foodType == "normal" then
        baseScore = baseScore + 1
    elseif foodType == "bonus" then
        baseScore = baseScore + 3
    elseif foodType == "gold" then
        baseScore = baseScore + 5
    elseif foodType == "poison" then
        baseScore = math.max(0, baseScore - 3)
        combo = 0
    end

    score = baseScore
end

function ScoreSystem.GetScore()
    return score
end

------------------------------------------------------------------------------------------------------------------------
-- Display
function ScoreSystem.Display()

    love.graphics.setColor(1, 1, 1)

    love.graphics.print( -- score
        "Score: " .. ScoreSystem.GetScore(),
        10,
        10
    )

    love.graphics.print( -- combo
        "Combo: " .. ScoreSystem.GetCombo(),
        10,
        30
    )
end

return ScoreSystem