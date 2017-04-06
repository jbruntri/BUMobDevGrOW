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
            x=816,
            y=0,
            width=380,
            height=380,

            sourceX = 20,
            sourceY = 8,
            sourceWidth = 420,
            sourceHeight = 420
        },
        {
            -- attack_2
            x=412,
            y=0,
            width=404,
            height=404,

            sourceX = 12,
            sourceY = 4,
            sourceWidth = 420,
            sourceHeight = 420
        },
        {
            -- attack_3
            x=0,
            y=0,
            width=412,
            height=412,

            sourceX = 4,
            sourceY = 4,
            sourceWidth = 420,
            sourceHeight = 420
        },
    },
    
    sheetContentWidth = 1196,
    sheetContentHeight = 412
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
