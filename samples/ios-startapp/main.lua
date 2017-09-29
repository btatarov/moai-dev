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

-- wait 10 seconds between interactions
local thread = MOAICoroutine.new ()
thread:run( function ()
    local delay_timer = MOAITimer:new ()
    delay_timer:setSpan ( 10 )

    MOAICoroutine.blockOnAction ( delay_timer:start () )
    coroutine:yield ()

    MOAIStartAppIOS.init ( '< YOUR APP ID >', true )
	MOAIStartAppIOS.initBannerWithParams ( 10, screenWidth - 20, true )

	MOAIStartAppIOS.cacheInterstitial ()
	MOAIStartAppIOS.cacheBanner () -- convenience method, banners are cached automatically

	MOAICoroutine.blockOnAction ( delay_timer:start () )
    coroutine:yield ()

	if MOAIStartAppIOS.hasCachedBanner () then
    	print ( 'Showing StartApp banner.' )
        MOAIStartAppIOS.showBanner ()
    else
    	print ( 'There is no cached banner.' )
    end

	MOAICoroutine.blockOnAction ( delay_timer:start () )
    coroutine:yield ()

    if MOAIStartAppIOS.hasCachedInterstitial () then
    	print ( 'Showing StartApp interstitial.' )
        MOAIStartAppIOS.showInterstitial ()
    else
    	print ( 'There is no cached interstitial.' )
    end

	MOAICoroutine.blockOnAction ( delay_timer:start () )
	coroutine:yield ()

	print ( 'Hiding StartApp banner.' )
	MOAIStartAppIOS.hideBanner ()
end )
