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
            
            self.moving = true
    
            local nextDiscI = ((self.engagedTo.index) % #self.engagedTo.parent.discs) + 1 -- Uuh, this seems pretty wierd... oh well..
            local nextDisc =  self.engagedTo.parent.discs[nextDiscI] -- yeah...

            

            -- Using my own function since tween loves to move the disc together with
            -- the player...
            local startAng  = self.pos:angleTo() -- I think I need a clone here?
            local targetAng = nextDisc.center:angleTo()
            local pDiscCenter = self.engagedTo.parent.parent.center -- parent is the circle, whos parent is the middle disc
            local rotVec = self.pos - pDiscCenter
            
            local t = 0
            local duration = 1
            
            Timer.during(duration, function(dt)
                t = t + dt
                local fraction = t/duration

                local curAng = -targetAng * fraction*(fraction-2) + startAng -- TODO: Make sure movement goes in the correct direction...
                player.pos = pDiscCenter + rotVec:rotated(curAng)
            end, function()
                player.moving = false
                player.engagedTo = nextDisc
            end)

            -- OK, WTF!? Keeping this here for posterity...
            --Timer.tween(duration, player.pos, targetV, "out-quad", function()
             --   player.moving = false
              --  player.engagedTo = nextDisc
            --end)
        end
    end
end

function player:draw(dt)
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.circle("fill", self.pos.x, self.pos.y, self.radius)
end
