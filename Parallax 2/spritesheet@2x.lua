--
-- created with TexturePacker (http://www.codeandweb.com/texturepacker)
--
-- $TexturePacker:SmartUpdate:201341a5d1f6fd65d2568863f6c7677f:13fca23a255a9dc9eb361d92d281b980:de6eb9fda28cd13ea07e9326597a6f0d$
--
-- local sheetInfo = require("mysheet")
-- local myImageSheet = graphics.newImageSheet( "mysheet.png", sheetInfo:getSheet() )
-- local sprite = display.newSprite( myImageSheet , {frames={sheetInfo:getFrameIndex("sprite")}} )
--

local SheetInfo = {}

SheetInfo.sheet =
{
    frames = {
    
        {
            -- attack_1
            x=408,
            y=0,
            width=190,
            height=190,

            sourceX = 10,
            sourceY = 4,
            sourceWidth = 210,
            sourceHeight = 210
        },
        {
            -- attack_2
            x=206,
            y=0,
            width=202,
            height=202,

            sourceX = 6,
            sourceY = 2,
            sourceWidth = 210,
            sourceHeight = 210
        },
        {
            -- attack_3
            x=0,
            y=0,
            width=206,
            height=206,

            sourceX = 2,
            sourceY = 2,
            sourceWidth = 210,
            sourceHeight = 210
        },
    },
    
    sheetContentWidth = 598,
    sheetContentHeight = 206
}

SheetInfo.frameIndex =
{

    ["attack_1"] = 1,
    ["attack_2"] = 2,
    ["attack_3"] = 3,
}

function SheetInfo:getSheet()
    return self.sheet;
end

function SheetInfo:getFrameIndex(name)
    return self.frameIndex[name];
end

return SheetInfo
