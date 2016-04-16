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

            player.engagedTo = false

            -- Using my own function since tween loves to move the disc together with
            -- the player...
            local startPos  = player.pos:clone() -- I think I need a clone here?
            local targetPos = nextDisc.center
            local targetV =   targetPos - startPos
            
            local t = 0
            local duration = 0.5
            
            Timer.during(duration, function(dt)
                t = t + dt
                local fraction = t/duration

                player.pos = -targetV * fraction*(fraction-2) + startPos
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
