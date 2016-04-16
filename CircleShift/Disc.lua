
-- Containing element for the "Circles"
Disc = {}

function Disc:new(disc)
    disc = disc or {}
    
    disc.center = disc.center or Vector(0, 0)
    disc.circles = disc.circles or {}
    
    function disc:addCircle(circle)
        circle.parent = self
        circle.index = #self.circles + 1
        table.insert(self.circles, Circle:new(circle))
    end

    function disc:draw()
        -- Draw all circles I know of
        for _, circle in ipairs(self.circles) do
            circle:draw()
        end
    end

    return disc
end
