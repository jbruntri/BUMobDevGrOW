local cx,cy = display.contentCenterX,display.contentCenterY
local ch,cw = display.contentHeight, display.contentWidth
local widget = require "widget"
-- requires
require "animations"
local composer = require "composer"
local scene = composer.newScene()

local physics = require "physics"
physics.start()
--physics.setDrawMode("hybrid")

local spellCollision = {categoryBits=1, maskBits=2}
local darkWizardCollisions = {categoryBits=2, maskBits=5}
local wizCollisions = {categoryBits=4, maskBits=2}

local fbSound= audio.loadSound("fire.wav")
local coinSound = audio.loadSound("coinSound.wav")
local gameTrack
local jung1 = {}
local jung2 = {}
local jung3 = {}
local jung4 = {}
local ground = {}
local char1
local char2 = {}
local xCount = 0
local a=0
local b=0
local i=0
local fireball={}
local n = 0
local fireballLock = false
local function wizCount()
  wizBan=wizBan+1;
  wizBanTxt.text="Wizards Banished: "..wizBan
end

local function scrollJung(self,event)
	if self.x < -1913 then
		self.x = 1920
	else
		self.x = self.x - self.speed
	end
end
local function scrollGround(self,event)
	if self.x < -450 then
		self.x = 2220
	else
		self.x = self.x - self.speed
	end
end

local function scrollEnemies(self,event)
	if self.x < -200 then
		self.x = 2100
	else
		self.x = self.x - self.speed
	end
end

local function projectile(self,event)
	if self.x > 1850 then
		self:removeSelf()
--    self = nil
    Runtime:removeEventListener("enterFrame", self)
	else
		self.x = self.x + self.speed
	end
end
local function onCollision(event)
--  print("YEs")
  if event.phase == "began" then
    if event.target.name=="fb" then
      event.target:removeSelf()
      event.target.enterFrame = onCollision
      Runtime:removeEventListener("enterFrame", event.target)
      event.other:setFillColor(0.8,0,0)
      event.other.hp = event.other.hp - char1.damage
    end

    if event.target.name=="wiz" then
      event.target.hp=event.target.hp - 5
        event.other.hp = event.other.hp - 15
    end

    if event.other.hp <= 0 then
      if event.other.name=="wiz" then
        fireballLock=true
        gTxt.text="Wiz has Died :(!\n All Hope Is Lost!"
      end
      event.other.enterFrame = scrollEnemies
      Runtime:removeEventListener("enterFrame",event.other)
      --physics.removeBody(event.other)
      event.other:removeSelf()
      wizCount();
      transition.to(coin, {delay = 0, time = 0, alpha = 0})
      bank=bank+level;
      coinCounter(xCount)
      coinCounterTxt.text = "Coins: "..bank
      print(bank)
      b=b-1;
    end

  end
end

-- background

local function enemySpawn()
  if b<20 then
    b=b+1;
    a=a+1

    char2[a]=display.newImage("Wizard2.png")
    char2[a]:scale(0.4,0.4)
    char2[a].x = cw+50
    char2[a].y = cy+cy*0.42
    char2[a].speed = 5 + math.floor(level/2)
    char2[a].hp = 8 + level
    char2[a].enterFrame = scrollEnemies
    Runtime:addEventListener("enterFrame", char2[a])
    physics.addBody(char2[a], {radius = 20})
    char2[a].filter = darkWizardCollisions;
    char2[a].gravityScale=0
    char2[a]:addEventListener("collision", onCollision)
    gTxt.text="";
    xCount = xCount+1
  end
end
local function genChar()
  char1=display.newImage("Wizard.png")
  char1:scale(0.4,0.4)
  char1.name="wiz"
  char1.x = cx - 0.4*cw
  char1.y = cy+cy*0.42
  char1.hp=30 + armor;
  char1.damage = 5+staff
  physics.addBody( char1, {radius=20} )
  char1.isSensor=true;
  char1.gravityScale=0
  char1:addEventListener("collision",onCollision)
  char1.filter=wizCollisions;
end

function buttonHandler(event)
    if event.phase == "began" then
      if fireballLock == false then
        audio.play(fbSound)
        fireball[n] = display.newImage("fball.png",char1.x+70,char1.y)
        fireball[n]:scale(3,3)
        fireball[n].speed = 20
        fireball[n].hp = 5 + staff
        fireball[n].name = "fb"
        fireball[n].enterFrame = projectile
        Runtime:addEventListener("enterFrame",fireball[n])
--        fireball[n].alpha = 0
        physics.addBody(fireball[n], {radius = 20})
        fireball[n].gravityScale = 0
        fireball[n].filter=spellCollision
        fireball[n]:addEventListener("collision", onCollision)
--        fireball[n]:addEventListener("postCollision", onPostCollision)
        n=n+1
        fireballLock = true
      end
    end
end

local function game (event)
  i = i+1

  if i>(25-skill) then
    if fireballLock then
      fireballLock=false
    end

  if i>15 then
      i=0
      spawn = math.random(0,100)
      if spawn>70-math.floor(level/2) then
        enemySpawn()
      end
    end
    if wizBan > 7*level+math.floor(level/3) then
      level=level+1;
      composer.gotoScene("upgrades")
    end
  end
end

music = audio.loadStream("music/airship.mp3")

function scene:create( event )
--  event.params.
  composer.removeHidden()
  local sceneGroup = self.view
  background = display.newImage("plx-1.png",cx,cy)
  background.width = 1920
  background.height = 1080
--  sceneGroup:insert(background)               ------------
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
--    sceneGroup:insert(jung1[i])                  ----------------
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
--    sceneGroup:insert(jung2[i])                  ----------------
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
--    sceneGroup:insert(jung3[i])                  ----------------
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
--    sceneGroup:insert(jung4[i])                  ----------------
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
--    sceneGroup:insert(ground[i])                  ----------------
    Runtime:addEventListener("enterFrame", ground[i])
  end
--- ADDED PLAYER ---
  genChar();

  wizBanTxt=display.newText("", cx, 50)
  coinCounterTxt = display.newText("", cx, 100)
  gTxt=display.newText("",cx,cy, system.nativeFont, 100)
  gTxt:setFillColor(1)
  button1 = widget.newButton{
      id = "spell1",
      label = "A",
      x = 0.90*display.contentWidth,
      y = 0.90*display.contentHeight,
      defaultFile = "leather button.png",
      overFile = "leather button pressed.png",
      onPress = buttonHandler
  }
  button1:scale(1.5,1.5)
--  sceneGroup:insert(button1) ----------------
  button1:toFront()
end

function coinCounter(val)
--  coin = display.newImage("coin.jpg")
--      coin.x = char2[val].x
--      coin.y = char2[val].y
--      coin.width = 30
--      coin.height = 30
--  transition.to(coin, {delay = 0, time = 0, alpha = 0})
--  transition.to(coin, {delay = 10, time = 100, char2[val].x, char2[val].y, alpha = 1})
  audio.play(coinSound)
  print("coin Sound")
end

local function endGame()
  composer.setVariable("finalScore", wizBan)
  composer.removeScene("highScores")
  composer.gotoScene("highScores")
end


function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

--    sceneGroup:insert(button1)
    Runtime:addEventListener("enterFrame", game)
--    openWiz = display.newSprite(sheetWiz2, sequence_Wiz2)
--    openWiz.x = cx
--    openWiz.y = cy
--    openWiz:scale(7,7)
----    openWiz:play()
--    openWiz2 = display.newSprite(sheetWiz3, sequence_Wiz3)
--    openWiz2.x = cx
--    openWiz2.y = cy-48
--    openWiz2:scale(7,7)
--    openWiz2:play()
	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
  audio.play( music, {channel=1, loops = -1})
	end
end

function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)

    for i = 0,1 do
      Runtime:removeEventListener("enterFrame", jung1[i])
      Runtime:removeEventListener("enterFrame", jung2[i])
      Runtime:removeEventListener("enterFrame", jung3[i])
      Runtime:removeEventListener("enterFrame", jung4[i])
      jung1[i]:removeSelf()
      jung2[i]:removeSelf()
      jung3[i]:removeSelf()
      jung4[i]:removeSelf()
    end
    background:removeSelf()

    for i = 0,5 do
      Runtime:removeEventListener("enterFrame", ground[i])
      ground[i]:removeSelf()
    end
      Runtime:removeEventListener("enterFrame", scrollEnemies)
      Runtime:removeEventListener("enterFrame", game)
    for i = wizBan+1,a do
--      char2[i].enterFrame = scrollEnemies
      Runtime:removeEventListener("enterFrame", char2[i])
      char2[i]:removeSelf()
    end


    if char1~=nil then char1:removeSelf() end

    button1:setEnabled(false)
    button1:removeSelf()
    wizBanTxt:removeSelf()
    coinCounterTxt:removeSelf()
    --audio.stop(fbSound)
    audio.stop( 1 )
    audio.dispose( menuTrack )
  elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen

	end
end


function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view

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
