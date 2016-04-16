
Game = {}

print(math.tau)

backgroundElements = {}

function Game:enter(previous, ...)
    for i=1, 1000 do
        table.insert(backgroundElements, {
            x=math.random(-1e4, 1e4), 
            y=math.random(-1e4, 1e4), 
            width=math.random(1e3), 
            height=math.random(1e3),
            r=math.random(150, 255),
            g=math.random(150, 255),
            b=math.random(150, 255),
            a=math.random(25, 75),
        })
    end

    -- Yeah, this is pretty confusing....
    Game.mainDisc = Disc:new{}
    Game.mainDisc:addCircle{radius=100}
    Game.mainDisc:addCircle{radius=200}

    Game.mainDisc.circles[1]:addDisc{angle=math.tau*(0/3)} -- Don't div by 0 silly..
    Game.mainDisc.circles[1].discs[1]:addCircle{radius=20}
    Game.mainDisc.circles[1].discs[1].circles[1]:addDisc()
    Game.mainDisc.circles[1].discs[1].circles[1].discs[1]:addCircle{radius=10}

    Game.mainDisc.circles[1]:addDisc{angle=math.tau*(1/3)}
    Game.mainDisc.circles[1].discs[2]:addCircle{radius=30}

    Game.mainDisc.circles[1]:addDisc{angle=math.tau*(2/3)}
    Game.mainDisc.circles[1].discs[3]:addCircle{radius=40}


    Game.mainDisc.circles[2]:addDisc{}
    Game.mainDisc.circles[2].discs[1]:addCircle{radius=30}

    Game.mainDisc.circles[2]:addDisc{angle=math.pi}
    Game.mainDisc.circles[2].discs[2]:addCircle{radius=10}
    
    -- Maybe put these as player:update stuff actually?
    
    player.engagedTo = Game.mainDisc.circles[1].discs[1]
    print(player.engagedTo)
    player.moving = false
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

    Game.mainDisc:draw()

    cam:detach()
end
