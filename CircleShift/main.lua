--[[
Circle Shift, a simple Lua/Löve2d game made for Ludum Dare 35
made by weakman54
]]--

-- Libraries
-- Init gamestates before input, so that input registers for all gamestates,
-- not just main.lua
Gamestate = require("libs/hump.gamestate")
Camera = require("libs/hump.camera")
Vector = require("libs/hump.vector")
Timer = require("libs/hump.timer")
Input = require("libs/boipushy.Input")
suit = require("libs/suit")


-- helper functions and constants
require("helperFunctions")


-- States
require("Start_Menu")
require("Game")
require("Pause_Menu")
require("Game_Over")

-- Entities
require("player")

function love.load(arg)
	-- Init Gamestate, do BEFORE Input!
    Gamestate.registerEvents()
   

    -- Init input and set bindings
    input = Input()
    
    input:bind("escape", "PauseQuit") -- Is there a better way to do this? bind as two different commands?
    input:bind("mouse1", "moveButton")
    

    -- Init Camera
    cam = Camera(player.pos.x, player.pos.y)


    -- Switch LAST, everything above needs to be initialized
    Gamestate.switch(Game) 
end


function love.update(dt)
    Timer.update(dt)
end


function love.draw(dt)
	suit.draw() -- Draw GUI last
end
