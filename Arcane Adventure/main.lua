local composer = require ("composer")
composer.isDebug = true

display.setStatusBar( display.HiddenStatusBar )
math.randomseed( os.time() )
audio.reserveChannels( 1 )
audio.setVolume(0.5, {channel = 1})
composer.gotoScene( "menu" )