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
            x=204,
            y=0,
            width=95,
            height=95,

            sourceX = 5,
            sourceY = 2,
            sourceWidth = 105,
            sourceHeight = 105
        },
        {
            -- attack_2
            x=103,
            y=0,
            width=101,
            height=101,

            sourceX = 3,
            sourceY = 1,
            sourceWidth = 105,
            sourceHeight = 105
        },
        {
            -- attack_3
            x=0,
            y=0,
            width=103,
            height=103,

            sourceX = 1,
            sourceY = 1,
            sourceWidth = 105,
            sourceHeight = 105
        },
    },
    
    sheetContentWidth = 299,
    sheetContentHeight = 103
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
