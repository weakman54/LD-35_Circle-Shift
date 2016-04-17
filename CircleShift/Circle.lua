
Circle = {}

function Circle:new(circle)
    circle = circle or {}
    
    circle.radius = circle.radius or 100
    circle.discs = circle.discs or {}
    
    function circle:addDisc(disc)
        disc = disc or {}
    
        disc.angle = disc.angle or 0 -- disc angle on parent circle
        local rotVec = Vector(self.radius, 0) -- Get 0 rotated vector
        rotVec:rotateInplace(disc.angle)
        disc.angle = rotVec:angleTo() -- exploit vector to normalize angle

        disc.center = self.parent.center + rotVec -- TODO: MATH, make sure it's not dependent on center being (0, 0)
        
        disc.parent = self
        disc.index = #self.discs + 1
        table.insert(self.discs, Disc:new(disc))
    end

    function circle:draw()
        -- Draw self
        love.graphics.circle("line", self.parent.center.x, self.parent.center.y, self.radius) -- OMFG... check you copy pastes...
        
        -- Draw all discs I know of:
        for _, disc in ipairs(self.discs) do
            disc:draw()
        end
    end

    

    return circle
end
