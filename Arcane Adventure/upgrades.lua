local cx,cy = display.contentCenterX,display.contentCenterY
local ch,cw = display.contentHeight, display.contentWidth
local widget = require "widget"
-- requires

local composer = require "composer"
local scene = composer.newScene()

local function gotoGame()
  composer.gotoScene("game", { time = 800, effect="fade"})
end

local function ButtonHandler(event)
  if event.phase == "ended" then
    if event.target.id == "upgrade1" then
      upl1 = 1
      upl2 = 1
      upg = 2
      damageamp = 5
      gotoGame()
    elseif event.target.id == "upgrade2" then
      upl2 = 0
      upg = 2
      damageamp = 10
      gotoGame()
    end
  end

    
end


function scene:create( event )
  print("wedidit")
  composer.removeHidden()
	local sceneGroup = self.view
  print("upl1 = "..upl1)
  print("upl2 = "..upl2)
  local background1 = display.newRect(cx,cy,cw,ch)
  background1:setFillColor(198/255,166/255,1/255)
  sceneGroup:insert(background1)
  local background2 = display.newRect(cx,cy,cw*0.95,ch*0.8)
  background2:setFillColor(145/255,94/255,7/255)
  sceneGroup:insert(background2) 
  if upl1 == 0 then
    playButton1 = widget.newButton{
      id = "upgrade1",
      x=cx,
      y=cy-100,
      defaultFile = "Button.png",
      overFile = "ButtonPressed.png",
      onEvent = ButtonHandler
    }
    sceneGroup:insert(playButton1)
  elseif upl1==1 then
    playButton1 = display.newImage("ButtonPressedLock.png",cx,cy-100)
    sceneGroup:insert(playButton1)
  end  
  if upl2 == 0 then
    playButton2 = display.newImage("ButtonPressedLock.png",cx,cy+100)
--    sceneGroup:insert(playButton2)
  elseif upl2 == 1 then
    playButton2 = widget.newButton{
      id = "upgrade2",
      x=cx,
      y=cy+100,
      defaultFile = "Button.png",
      overFile = "ButtonPressed.png",
      onEvent = ButtonHandler
      }  
    sceneGroup:insert(playButton2)
  end
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
    playButton1:removeSelf()
    playButton2:removeSelf()
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
--    playButton1:removeSelf()
--    playButton2:removeSelf()
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
