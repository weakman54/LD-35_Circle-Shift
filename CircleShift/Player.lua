player = {}

player.pos = Vector(0, 0)
player.radius = 10
player.moving = false

function player:update(dt)
    pDiscCenter = self.engagedTo.parent.parent.center -- parent is the circle, whos parent is the middle disc
    mouseVector = Vector(cam:worldCoords(love.mouse.getPosition()))

    tangentVector = self.engagedTo.center - pDiscCenter
    mouseTarget   = mouseVector - pDiscCenter
    
    
    direction = 1
    if tangentVector:angleTo(mouseTarget) > math.pi then
        direction = -1
    end


    local nextDiscI = self.engagedTo.index + direction
    -- Gonna do the modulo myself for now, to make sure it's correct, optimise proper later
    if nextDiscI > #self.engagedTo.parent.discs then
        nextDiscI = 1
    elseif nextDiscI < 1 then
        --print("LESSS THAN 1")
        nextDiscI = #self.engagedTo.parent.discs
    end
    
    --print("SIZE:", #self.engagedTo.parent.discs, "INDEX: ", nextDiscI)
    
    local nextDisc  = self.engagedTo.parent.discs[nextDiscI] -- yeah...

    print(tangentVector:angleTo(mouseTarget)/math.tau, direction, nextDiscI)



    if not self.moving then
        if self.engagedTo then
            player.pos = self.engagedTo.center
        end
    
        if input:pressed("movement") then
            print("Move")
            
            self.moving = true
            
            -- Uuh, this seems pretty wierd... oh well..
           


            -- Using my own function since tween loves to move the disc together with
            -- the player...
            local startAng  = self.engagedTo.angle          -- TODO, make sure angles are calculated from current discs, not (0, 0)
            local targetAng = nextDisc.center:angleTo()
            local rotVec = self.pos - pDiscCenter -- get 0 rotated vector from parent center to self.center
            rotVec:rotateInplace(startAng)
            print("start", "\ttarget", "\tpDiscCenter", "rotVec")
            print(startAng/math.tau, targetAng/math.tau, pDiscCenter, rotVec)
            
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

    love.graphics.line(pDiscCenter.x, pDiscCenter.y, pDiscCenter.x + tangentVector.x, pDiscCenter.y + tangentVector.y)
    love.graphics.line(pDiscCenter.x, pDiscCenter.y, pDiscCenter.x + mouseTarget.x,   pDiscCenter.y + mouseTarget.y)
end
