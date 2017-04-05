local cx,cy = display.contentCenterX,display.contentCenterY
local ch,cw = display.contentHeight, display.contentWidth
local widget = require "widget"
-- requires 

local composer = require "composer"

local function gotoGame()
  composer.removeScene( "game" )
  openChest:play()
  composer.gotoScene("game", { time = 2000, effect="fade"})
end

local function gotoTutorial()
  composer.removeScene("tutorial")
  composer.gotoScene( "tutorial" ,{time=800, effect="crossFade"})
end

local menuTrack

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


function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen
  local background = display.newImage(sceneGroup, "plx-1.png",cx,cy)
  background.width = 1920
  background.height = 1080
--  local title = display.newImageRect( sceneGroup, "title.png", 500, 80)
--  title.x = display.contentCenterX
--  title.y = 200
  local openChest = display.newSprite(sheetChest, sequence_Chest)
  openChest.x = display.contentCenterX
  openChest.y = display.contentCenterY
  openChest:scale(3.5,3.5)
  local playShadow = display.newText(sceneGroup,"Play!", cx+5,cy+5, "Harry P", 150)
  playShadow:setFillColor(0)
  local playButton = display.newText(sceneGroup, "Play!", cx,cy, "Harry P", 150)
  
--  local tutorialButton = display.newText( sceneGroup, "High Scores", display.contentCenterX, 810, native.systemFont, 44 )
    
  playButton:addEventListener( "tap", gotoGame)
--    tutorialButton:addEventListener("tap", gotoTutorial)
 --   menuTrack = audio.loadStream( "")
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

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen
      audio.stop( 1 )
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


