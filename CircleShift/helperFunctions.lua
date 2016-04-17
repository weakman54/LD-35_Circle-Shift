
Width, Height = love.graphics.getWidth(), love.graphics.getHeight()

function resetMenuUI(titleStr)
    -- Resets the GUI to a standard Menu layout.
    -- Just add rows to add elements in the middle column with proper padding

    suit.layout:reset(0, 0)
    suit.layout:padding(0, 10)

    -- Set cellwidth to 1/5 of window width and pad to center col
    suit.layout:col(Width/5, 30)
    suit.layout:col()
    suit.layout:col()

    if titleStr then
        suit.Label(titleStr, suit.layout:row())
    end
end


-- Draws the vector as a line with start pos start
function drawVec(start, vector)
    local targetVec = start + vector
    love.graphics.line(start.x, start.y, targetVec.x, targetVec.y)
end

function normalizeAngle(angle)
    while angle <= 0 do
        angle = angle + math.tau
    end
    return angle
end

function round(num, idp)
    local mult = 10^(idp or 0)
    if num >= 0 then return math.floor(num * mult + 0.5) / mult
    else return math.ceil(num * mult - 0.5) / mult end
end
