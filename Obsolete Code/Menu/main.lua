cx,cy = display.contentCenterX,display.contentCenterY
ch,cw = display.contentHeight, display.contentWidth
widget = require "widget"
-- requires 

--require "sprite"

--local storyboard = require ("storyboard")
--local scene = storyboard.newScene()
background = display.newImage("plx-1.png",cx,cy)
background.width = 1920
background.height = 1080
local chestOptions = 
{
width = 308,
height = 400,
numFrames = 6
  
}
local sheetChest = graphics.newImageSheet("Chest.png", chestOptions)

local sequence_Chest = {
  
  {
    name = "norm",
    start = 1,
    count = 6,
    time = 1600,
    loopCount = 1,
    loopDirection = "forward"
  }
}
local openChest = display.newSprite(sheetChest, sequence_Chest)
openChest.x = display.contentCenterX
openChest.y = display.contentCenterY
openChest:scale(3.5,3.5)
playShadow = display.newText("Play!", cx+5,cy+5, "Harry P", 150)
playShadow:setFillColor(0)
play = display.newText("Play!", cx,cy, "Harry P", 150)

openChest:play()

