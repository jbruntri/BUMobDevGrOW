cx,cy = display.contentCenterX,display.contentCenterY
ch,cw = display.contentHeight, display.contentWidth
widget = require "widget"
-- requires 

local physics = require "physics"
physics.start()
--physics.setDrawMode("hybrid")
--require "sprite"

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

function scrollEnemies(self,event)
	if self.x < -200 then
		self.x = 2100
	else 
		self.x = self.x - self.speed
	end
end
fireball={}
n = 0
function projectile(self,event)
	if self.x > 1850 then
		self:removeSelf()
    Runtime:removeEventListener("enterFrame", self)
	else 
		self.x = self.x + self.speed
	end
end
function onCollision(event)
  print("YEs")
  if event.phase == "began" then
      
      print(event.object1.name.." collided with "..event.object2.name)
    
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

char1=display.newImage("Wiz/Wizard.png")
char1:scale(0.4,0.4)
char1.x = cx - 0.4*cw
char1.y = cy+cy*0.42
--char1.speed = 2
--char1.enterFrame = scrollEnemies
--Runtime:addEventListener("enterFrame", char1)

char2=display.newImage("Wiz/Wizard2.png")
char2:scale(0.4,0.4)
char2.x = 1.5*cw
char2.y = cy+cy*0.42
char2.speed = 8
char2.hp = 15
char2.enterFrame = scrollEnemies
Runtime:addEventListener("enterFrame", char2)
physics.addBody(char2, "static", {radius = 20})
char2.name = "Enemy Wizard 1"
--char2.collision = onCollision
--char2:addEventListener("collision")
char3=display.newImage("Wiz/Wizard2.png")
char3:scale(0.4,0.4)
char3.x = cw-cw*0.1
char3.y = cy+cy*0.42
char3.speed = 8
char3.hp = 15
char3.enterFrame = scrollEnemies
Runtime:addEventListener("enterFrame", char3)
physics.addBody(char3, "static", {radius = 20})
char3.name = "Enemy Wizard 2"
--char3.collision = onCollision
--char3:addEventListener("collision")

function buttonHandler(event)
    if event.phase == "began" then
      fireball[n] = display.newCircle(char1.x+50,char1.y, 20)
      fireball[n]:setFillColor(1,0,0)
      fireball[n].speed = 20
      fireball[n].name = "Fireball "..n
      fireball[n].enterFrame = projectile
      Runtime:addEventListener("enterFrame",fireball[n])
      physics.addBody(fireball[n], "static", {radius = 20})
--      fireball[n].collision = onCollision
--      fireball[n]:addEventListener("collision")
      n=n+1
      end
end

button1 = widget.newButton{
    id = "spell1",
    label = "Spell 1",
    shape = "circle",
    radius = 100,
    x = 0.90*display.contentWidth,
    y = 0.90*display.contentHeight,    
    fillColor = { default={1,0,0,1}, 
      over={1,0.1,0.7,0.4} },
    
    onPress = buttonHandler
    
}
button1.alpha = 0.4
Runtime:addEventListener("collision", onCollision)
--function touchScreen(event)
--    print("touch")
--   if event.phase == "began" then
--   	 jet.enterFrame = activateJets
--   	 Runtime:addEventListener("enterFrame", jet)
--   end
   
--   if event.phase == "ended" then
--   	 Runtime:removeEventListener("enterFrame", jet)
--   end

--end

--function onCollision(event)
--	if event.phase == "began" then
--	  if jet.collided == false then 
--	    jet.collided = true
--	    jet.bodyType = "static"
--	    explode()

--	  end
--	end
--end
	
--    city1.enterFrame = scrollCity
--    Runtime:addEventListener("enterFrame", city1)

--    city2.enterFrame = scrollCity
--    Runtime:addEventListener("enterFrame", city2)

--    city21.enterFrame = scrollCity
--    Runtime:addEventListener("enterFrame", city21)

--    city22.enterFrame = scrollCity
--    Runtime:addEventListener("enterFrame", city22)

--    city23.enterFrame = scrollCity
--    Runtime:addEventListener("enterFrame", city23)

--    city3.enterFrame = scrollCity
--    Runtime:addEventListener("enterFrame", city3)

--    city4.enterFrame = scrollCity
--    Runtime:addEventListener("enterFrame", city4)
    
--    city41.enterFrame = scrollCity
--    Runtime:addEventListener("enterFrame", city41)
    
--    city42.enterFrame = scrollCity
--    Runtime:addEventListener("enterFrame", city42)
        
--    city43.enterFrame = scrollCity
--    Runtime:addEventListener("enterFrame", city43)
    
--  Runtime:addEventListener("collision", onCollision)
--	Runtime:addEventListener("touch", touchScreen)




--	Runtime:removeEventListener("touch", touchScreen)
--	Runtime:removeEventListener("enterFrame", city1)
--	Runtime:removeEventListener("enterFrame", city2)
--	Runtime:removeEventListener("enterFrame", city3)
--	Runtime:removeEventListener("enterFrame", city4)
--	Runtime:removeEventListener("collision", onCollision)






