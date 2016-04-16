-- pause gamestate
Pause_Menu = {}

function Pause_Menu:enter(from)
    self.from = from -- record previous state
end

function Pause_Menu:update(dt)
    
end

function Pause_Menu:draw(dt)
    self.from:drawGUI()
    self.from:draw(dt)
    
    -- Put an overlay over the screen TODO: make sure this works with cameras
    love.graphics.setColor(0, 0, 0, 100)
    love.graphics.rectangle("fill", 0, 0, Width, Height)
    love.graphics.setColor(255, 255, 255, 255)

    self:drawGUI()
    suit.draw()
end


function Pause_Menu:drawGUI()
    resetMenuUI("Paused")

    backButton = suit.Button("Back", suit.layout:row())
    menuButton = suit.Button("Menu", suit.layout:row())

    if backButton.hit then
        paused = false
        Gamestate.switch(Game) -- Is it actually better to switch and not push?
    end

    if menuButton.hit then
        paused = false
        Gamestate.switch(Start_Menu) -- What happens with the pushed pause state?
    end
end
