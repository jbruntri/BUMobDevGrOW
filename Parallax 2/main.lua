 cx,cy = display.contentCenterX,display.contentCenterY
-- requires

--local physics = require "physics"
--physics.start()
display.setStatusBar( display.HiddenStatusBar )
local sheetInfo = require("spritesheet@4x")
local sheetArray = sheetInfo:getSheet()

local imageSheet = graphics.newImageSheet( "spritesheet@4x.png",  sheetInfo:getSheet() )
--require "sprite"

local sequenceData = {
	name="attack",
	start=1,
	count=3,
	time=1000,
	loop=0,
	loopDirection = "forward"
}


--local storyboard = require ("storyboard")
--local scene = storyboard.newScene()
function scrollJung(self,event)
	if self.x < -1913 then
		self.x = 1920
	else
		self.x = self.x - self.speed
	end
end
function scrollGround(self,event)
	if self.x < -450 then
		self.x = 2220
	else
		self.x = self.x - self.speed
	end
end
-- background
jung1 = {}
jung2 = {}
jung3 = {}
jung4 = {}
ground = {}

background = display.newImage("plx-1.png",cx,cy)
background.width = 1920
background.height = 1080

for i = 0,1 do
jung1[i]= display.newImage("plx-2.png")
jung1[i].anchorX = 0
jung1[i].anchorY = 1
jung1[i].width = 1920
jung1[i].height = 1080
jung1[i].x = 0 + 1920*i
jung1[i].y = 1080
jung1[i].speed = 1
jung1[i].enterFrame = scrollJung
Runtime:addEventListener("enterFrame", jung1[i])
end

for i = 0,1 do
jung2[i]= display.newImage("plx-3.png")
jung2[i].anchorX = 0
jung2[i].anchorY = 1
jung2[i].width = 1920
jung2[i].height = 1080
jung2[i].x = 0 + 1920*i
jung2[i].y = 1080
jung2[i].speed = 2
jung2[i].enterFrame = scrollJung
Runtime:addEventListener("enterFrame", jung2[i])
end

for i = 0,1 do
jung3[i]= display.newImage("plx-4.png")
jung3[i].anchorX = 0
jung3[i].anchorY = 1
jung3[i].width = 1920
jung3[i].height = 1080
jung3[i].x = 0 + 1920*i
jung3[i].y = 1080
jung3[i].speed = 3
jung3[i].enterFrame = scrollJung
Runtime:addEventListener("enterFrame", jung3[i])
end

for i = 0,1 do
jung4[i]= display.newImage("plx-5.png")
jung4[i].anchorX = 0
jung4[i].anchorY = 1
jung4[i].width = 1920
jung4[i].height = 1080
jung4[i].x = 0 + 1920*i
jung4[i].y = 1080
jung4[i].speed = 5
jung4[i].enterFrame = scrollJung
Runtime:addEventListener("enterFrame", jung4[i])
end

for i = 0,5 do
ground[i] = display.newImage("jground.png")
ground[i].anchorX = 0
ground[i].anchorY = 1
ground[i].width = 450
ground[i].height = 200
ground[i].x = 0 + 450*i
ground[i].y = 1150
ground[i].speed = 5
ground[i].enterFrame = scrollGround
Runtime:addEventListener("enterFrame", ground[i])
end

local character = display.newSprite( imageSheet, sequenceData )
character.x=character.width
character.y=1150-character.height
character:toFront();
character:setSequence("attack")
character:play()
