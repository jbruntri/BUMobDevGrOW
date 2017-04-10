local cx,cy = display.contentCenterX,display.contentCenterY
local ch,cw = display.contentHeight, display.contentWidth
local widget = require "widget"
-- requires

local composer = require "composer"
local scene = composer.newScene()

local function gotoGame(event)
  composer.gotoScene("game", { time = 800, effect="fade"})
end


function scene:create( event )
  print("wedidit")
  composer.removeHidden()
	local sceneGroup = self.view
  
  local background1 = display.newRect(cx,cy,cw,ch)
  background1:setFillColor(198/255,166/255,1/255)
  sceneGroup:insert(background1)
  local background2 = display.newRect(cx,cy,cw*0.95,ch*0.8)
  background2:setFillColor(145/255,94/255,7/255)
  sceneGroup:insert(background2)      
  local playButton = display.newText(sceneGroup,"Play!", cx,cy, "Harry P", 150)
  sceneGroup:insert(playButton)
  playButton:addEventListener( "tap", gotoGame)
  
end



function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
--  audio.play( menuTrack, {channel=1, loops = -1})
	end
end


function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)
    composer.removeScene("game")    

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen
--      audio.stop( 1 )
	end
end


function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view
--  audio.dispose( menuTrack )
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
