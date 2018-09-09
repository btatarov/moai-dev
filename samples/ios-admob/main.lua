screenWidth, screenHeight = MOAIEnvironment.horizontalResolution, MOAIEnvironment.verticalResolution

MOAISim.openWindow ( "test", screenWidth, screenHeight )

-- to better see the banner
MOAIGfxDevice.setClearColor ( 1, 105 / 256, 180 / 256, 1 ) -- pink

viewport = MOAIViewport.new ()
viewport:setSize ( screenWidth, screenHeight )
viewport:setScale ( screenWidth, screenHeight )

layer = MOAILayer2D.new ()
layer:setViewport ( viewport )
MOAISim.pushRenderPass ( layer )

gfxQuad = MOAIGfxQuad2D.new ()
gfxQuad:setTexture ( "moai.png" )
gfxQuad:setRect ( -64, -64, 64, 64 )

prop = MOAIProp2D.new ()
prop:setDeck ( gfxQuad )
layer:insertProp ( prop )

prop:moveRot ( 720, 2.0 )

-- to test touch events on our main view
function onPointerEvent ( x, y )
	print ( 'touch recognized' )
end
MOAIInputMgr.device.touch:setCallback ( onPointerEvent )

-- wait 5 seconds between interactions
local thread = MOAICoroutine.new ()
thread:run( function ()
    local delay_timer = MOAITimer:new ()
    delay_timer:setSpan ( 5 )

    MOAICoroutine.blockOnAction ( delay_timer:start () )
    coroutine:yield ()

    MOAIAdMobIOS.init ( '< YOUR APP ID >', '< YOUR UNIT ID >' )
	MOAIAdMobIOS.initBannerWithParams ( '< YOUR UNIT ID >', 10, true )

    MOAICoroutine.blockOnAction ( delay_timer:start () )
    coroutine:yield ()

    MOAIAdMobIOS.cacheInterstitial ()
	MOAIAdMobIOS.cacheBanner ()

    MOAICoroutine.blockOnAction ( delay_timer:start () )
    coroutine:yield ()

    if MOAIAdMobIOS.hasCachedInterstitial () then
    	print ( "Showing AdMob interstitial." )
        MOAIAdMobIOS.showInterstitial ()
    else
    	print ( "There is no cached interstitial." )
    end

    MOAICoroutine.blockOnAction ( delay_timer:start () )
    coroutine:yield ()

	if MOAIAdMobIOS.hasCachedBanner () then
    	print ( "Showing AdMob banner." )
        MOAIAdMobIOS.showBanner ()

        MOAICoroutine.blockOnAction ( delay_timer:start () )
        coroutine:yield ()

        print ( "Hiding AdMob banner." )
        MOAIAdMobIOS.hideBanner ()
    else
    	print ( "There is no cached banner." )
    end
end )
