
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
