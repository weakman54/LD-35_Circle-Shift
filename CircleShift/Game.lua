
Game = {}

backgroundElements = {}

function Game:enter(previous, ...)
   for i=1, 1000 do
       table.insert(backgroundElements, {
           x=math.random(-1e4, 1e4), 
           y=math.random(-1e4, 1e4), 
           width=math.random(1e3), 
           height=math.random(1e3),
           r=math.random(100, 255),
           g=math.random(100, 255),
           b=math.random(100, 255),
           a=math.random(100, 255),
       })
   end
end

function Game:update(dt)
    player:update(dt)
    cam:lookAt(player.pos.x, player.pos.y)
end

function Game:draw(dt)
    cam:attach()
    for _, rect in ipairs(backgroundElements) do
        love.graphics.setColor(rect.r, rect.g, rect.b, rect.a)
        love.graphics.rectangle("fill", rect.x, rect.y, rect.width, rect.height)
    end
    

    player:draw(dt)
    cam:detach()
end
