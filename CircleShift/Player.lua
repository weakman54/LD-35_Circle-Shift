player = {}

player.pos = Vector(0, 0)
player.radius = 10
player.moving = false

function player:update(dt)
    if not self.moving then
        --print("Player Update  Pos: (" .. round(player.pos.x, 2) .. ", " .. round(player.pos.y, 2) .. ")")
        local parentDiscs = self.engagedTo.parent.discs
        parentParentCenter = self.engagedTo.parent.parent.center
        
        
        -- Calculate angle to mouse from current engaged disc, set new disc accordingly
        engagedVector = self.engagedTo.center - parentParentCenter
        mouseVec = Vector(cam:worldCoords(love.mouse.getPosition()))
    
        local engagedMouseAng = normalizeAngle(mouseVec:angleTo(engagedVector))
    
        local direction = 1 -- CW
        if engagedMouseAng/math.tau > 0.5 then
            direction = -1 -- CCW
        end
    
    
        local curDiscI   = self.engagedTo.index
        local nextDiscI  = curDiscI + direction
    
        if nextDiscI > #parentDiscs then
            nextDiscI = 1
        elseif nextDiscI < 1 then
            nextDiscI = #parentDiscs
        end
    
        nextDisc = parentDiscs[nextDiscI]
        
        nextVector = nextDisc.center - parentParentCenter
        local engagedNextAng = normalizeAngle(engagedVector:angleTo(nextVector))
    
    
        local diffAng = (direction == 1) and normalizeAngle(nextVector:angleTo() - engagedVector:angleTo()) 
                                         or -normalizeAngle(engagedVector:angleTo() - nextVector:angleTo())
    
        
        if self.engagedTo then
            self.pos = self.engagedTo.center
        end
    
        if input:pressed("movement") then
            self.moving = true

            local t = 0
            local duration = 0.5
            
            Timer.during(duration, function(dt)
                t = t + dt
                local fraction = t/duration

                local curAng = diffAng * -fraction*(fraction-2) -- TODO: This is incorrect!
                self.pos = parentParentCenter + engagedVector:rotated(curAng)
                --print("TIMER FUNCTION Pos: (" .. round(self.pos.x, 2) .. ", " .. round(self.pos.y, 2) .. ")", fraction, engagedVector)
            end, function()
                self.moving = false
                self.engagedTo = nextDisc
            end)
        end
    end
end

function player:draw(dt)
    --print("Player Draw    Pos: (" .. round(player.pos.x, 2) .. ", " .. round(player.pos.y, 2) .. ")")
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.circle("fill", self.pos.x, self.pos.y, self.radius)

    -- Show next:
    love.graphics.setColor(255, 0, 0, 255)
    love.graphics.circle("fill", nextDisc.center.x, nextDisc.center.y, 5)
    love.graphics.circle("fill", parentParentCenter.x, parentParentCenter.y, 5)
    drawVec(parentParentCenter, engagedVector)
    drawVec(parentParentCenter, nextVector)
    drawVec(parentParentCenter, mouseVec)
    love.graphics.setColor(255, 255, 255, 255)
end
