local cx,cy = display.contentCenterX,display.contentCenterY
local ch,cw = display.contentHeight, display.contentWidth
local widget = require "widget"
-- requires

local composer = require "composer"
local scene = composer.newScene()
local openChest

local function spriteListener(event)
    if event.phase == "ended" then
      composer.gotoScene("game", { time = 800, effect="fade"})
    end

end

local function gotoGame()
  openChest:play()
end

local function gotoHighScores()
  composer.removeScene("highScores")
  composer.gotoScene("highScores",{time= 800, effect = "crossFade"})
end



--local function gotoTutorial()
--  composer.removeScene("tutorial")
--  composer.gotoScene( "tutorial" ,{time=800, effect="crossFade"})
--end

local menuTrack

local function scrollBack(self,event)
	if self.x < -955 then
		self.x = cx+cw
	else
		self.x = self.x - self.speed
	end
end

function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen
  local chestOptions = {width = 308,height = 400,numFrames = 6}
  local sheetChest = graphics.newImageSheet("Chest.png", chestOptions)
  local sequence_Chest = {{name = "norm",start = 1,count = 6,time = 1000,loopCount = 1,loopDirection = "forward"}}
  local background1 = display.newImage(sceneGroup, "menuBack.png",cx,cy)
  background1.width = 1920
  background1.height = 1080
  background1.speed = 3
  background1.enterFrame = scrollBack
  Runtime:addEventListener("enterFrame",background1)
  local background2 = display.newImage(sceneGroup, "menuBack.png",cx+cw,cy)
  background2.width = 1920
  background2.height = 1080
  background2.speed = 3
  background2.enterFrame = scrollBack
  Runtime:addEventListener("enterFrame",background2)
  openChest = display.newSprite(sheetChest, sequence_Chest)
  openChest.x = display.contentCenterX
  openChest.y = display.contentCenterY
  openChest:scale(3.5,3.5)
  openChest:addEventListener("sprite",spriteListener)
  sceneGroup:insert(openChest)
  local titleShadow = display.newText(sceneGroup, "Arcane Adventure", cx+5, 0.25*cy+5,"Harry P", 200)
  titleShadow:setFillColor(0)
  local title = display.newText(sceneGroup, "Arcane Adventure", cx, 0.25*cy,"Harry P", 200)
  title:setFillColor(0.75,0,0.9)
  local playShadow = display.newText(sceneGroup,"Play!", cx+5,cy+5, "Harry P", 150)
  playShadow:setFillColor(0)
  local playButton = display.newText(sceneGroup,"Play!", cx,cy, "Harry P", 150)
  local highScoreButton = display.newText(sceneGroup, "High Scores", display.contentCenterX, 810, native.systemFont, 44)
  --local tutorialButton = display.newText( sceneGroup, "High Scores", display.contentCenterX, 810, native.systemFont, 44 )

    playButton:addEventListener( "tap", gotoGame)
    highScoreButton:addEventListener("tap", gotoHighScores)
    --tutorialButton:addEventListener("tap", gotoTutorial)
    menuTrack = audio.loadStream("music/castle2.mp3")
end

function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
  audio.play( menuTrack, {channel=1, loops = -1})
	end
end


function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)
    audio.stop( 1 )
	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen
     
	end
end


function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view
  audio.dispose( menuTrack )
end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
