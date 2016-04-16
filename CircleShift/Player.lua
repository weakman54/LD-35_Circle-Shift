player = {}

player.pos = Vector(0, 0)
player.radius = 10
player.moving = false

function player:update(dt)
    if not self.moving then
        if self.engagedTo then
            player.pos = self.engagedTo.center
        end
    
        if input:pressed("movement") then
            print("Move")
            --self.moving = true
    
            local nextDiscI = ((self.engagedTo.index) % #self.engagedTo.parent.discs) + 1 -- Uuh, this seems pretty wierd... oh well..
            local nextDisc =  self.engagedTo.parent.discs[nextDiscI] -- yeah...
    
            self.engagedTo = nextDisc
        end
    end
end

function player:draw(dt)
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.circle("fill", self.pos.x, self.pos.y, self.radius)
end
