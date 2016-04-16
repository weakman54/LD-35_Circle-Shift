
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
    cam:lookAt(player.pos.x, player.pos.y)
    mousePos = Vector(cam:worldCoords(love.mouse.getPosition()))
    
    if not player.moving then
         -- A-B points to A
        jumpVec = (mousePos-player.pos):trimInplace(100)

        targetPos = player.pos + jumpVec
    end
   

    if input:down("moveButton") and not player.moving then        
        Timer.tween(0.5, player.pos, {x=targetPos.x, y=targetPos.y}, "out-quad", function() player.moving = false end)
        player.moving = true

        -- Remember to update all the positions for drawing
        cam:lookAt(player.pos.x, player.pos.y)
        mousePos = Vector(cam:worldCoords(love.mouse.getPosition()))
        jumpVec = (mousePos-player.pos):trimInplace(100)
    end
end

function Game:draw(dt)
    cam:attach()

    for _, rect in ipairs(backgroundElements) do
        love.graphics.setColor(rect.r, rect.g, rect.b, rect.a)
        love.graphics.rectangle("fill", rect.x, rect.y, rect.width, rect.height)
    end

    love.graphics.setColor(255, 255, 0, 255)
    love.graphics.rectangle("fill", mousePos.x, mousePos.y, 10, 10)

    love.graphics.line(player.pos.x, player.pos.y, targetPos.x, targetPos.y)

    player:draw(dt)

    cam:detach()
end
