
Start_Menu = {}

function Start_Menu:update(dt)
    resetMenuUI("Circle Shift")

    suit.layout:row()

    startButton   = suit.Button("Start"  , suit.layout:row())
    optionsButton = suit.Button("Options", suit.layout:row())
    quitButton    = suit.Button("Quit"   , suit.layout:row())
    
    -- Check GUI state
    if startButton.hit then
        Gamestate.switch(Game)
    end

    if optionsButton.hit then
        -- Goto options menu
        print("Not implemented!")
    end

    if quitButton.hit then
        love.event.quit()
    end


    -- Check input
    if input:pressed("PauseQuit") then
        love.event.quit()
    end
end

function Start_Menu:draw(dt)
end
