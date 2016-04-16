player = {}

player.pos = Vector(0, 0)
player.radius = 10


function player:draw(dt)
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.circle("fill", self.pos.x, self.pos.y, self.radius)
end
