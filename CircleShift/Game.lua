
Game = {}



function Game:init()
    -- Initialize gamestate
    Game.paused = false
end

function Game:enter(previous, ...)
    print("Game enter")
    if previous == Start_Menu then
        print("...From Start_Menu")
        -- Reinitialize gamestate
        Game.paused = false
        
    elseif previous == Pause_Menu then
        print("From pause menu")
        -- Don't reset the gamestate =)
    end
end

function Game:leave()
    print("Game leave")
end


function Game:update(dt)
    -- toggle pause
    if input:pressed("PauseQuit") then
        Game.paused = not Game.paused -- Can this be removed?
        Gamestate.switch(Pause_Menu)
    end

    self:drawGUI()
end

function Game:draw(dt)
    
end


function Game:drawGUI()
    resetMenuUI()
    suit.layout:col()
    suit.Label("Game", suit.layout:row())
end
