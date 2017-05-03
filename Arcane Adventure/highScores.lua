local composer = require "composer"
local scene = composer.newScene()
local widget = require "widget"

local json = require "json"
local scoresTable = {}
local filepath = system.pathForFile("wizBan.json", system.DocumentsDirectory)

local function loadScores()
  local file = io.open(filepath,"r")
  if file then
    local contents = file:read("*a")
    io.close(file)
    scoresTable = json.decode(contents)
  end
  if scoresTable == nil or #scoresTable == 0 then
    scoresTable = {0,0,0,0,0,0,0,0,0,0}
  end
end

local function saveScores()
  for i = #scoresTable, 11, -1 do
    table.remove(scoresTable, i)
  end
  local file = io.open(filePath, "w")
  local temp = json.encode(scoresTable)
  file:write(temp)
  io.close(file)
end

local function gotoMenu(event)
  composer.gotoScene("menu")
end

  

function scene:create(event)  
  
  composer.removeHidden()
  local sceneGroup = self.view
  loadScores()
  
  table.insert(scoresTable, composer.getVariable("finalScore"))
  
  local function compare(a, b)
    return a>b
  end
  table.sort(scoresTable, compare)
  saveScores()
  
  
  background = display.newImage("plx-1.png",cx,cy)
  background.width = 1920
  background.height = 1080
  
  highScoresTitle = display.newText("High Scores", cx, 100,44)
  
  for i = 1, 10 do
    if scoresTable[i] then
      local yPos = 150+(i*56)
      local rankNum = display.newText(i..") ", cx-50, yPos, 35)
      rankNum:setFillColor(0.8)
      rankNum.anchorX = 1
      
      local thisScore = display.newText(scoresTable[i], cx-50, yPos, 35)
      thisScore.anchorX = 0
    end
  end
  local menuButton = display.newText("Menu",cx, 810, 40)
  menuButton:setFillColor(0.75, 0.78, 1)
  menuButton:addEventListener("tap", gotoMenu)
end


