MOAISim.openWindow ( "test", 320, 480 )

-- to better see the banner
MOAIGfxDevice.setClearColor ( 1, 105 / 256, 180 / 256, 1 ) -- pink

viewport = MOAIViewport.new ()
viewport:setSize ( 320, 480 )
viewport:setScale ( 320, 480 )

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

-- wait 10 seconds between interactions
local thread = MOAICoroutine.new ()
thread:run( function ()
    local delay_timer = MOAITimer:new ()
    delay_timer:setSpan ( 10 )

    MOAICoroutine.blockOnAction ( delay_timer:start () )
    coroutine:yield ()

    MOAIAdMobAndroid.init ( '< YOUR UNIT ID >' )
	MOAIAdMobAndroid.initBannerWithParams ( '< YOUR UNIT ID >', 640, 0, 10, true )

    MOAICoroutine.blockOnAction ( delay_timer:start () )
    coroutine:yield ()

    MOAIAdMobAndroid.cacheInterstitial ()
	MOAIAdMobAndroid.cacheBanner ()

    MOAICoroutine.blockOnAction ( delay_timer:start () )
    coroutine:yield ()

    if MOAIAdMobAndroid.hasCachedInterstitial () then
    	print ( "Showing Admob interstitial." )
        MOAIAdMobAndroid.showInterstitial ()
    else
    	print ( "There is no cached interstitial." )
    end

	if MOAIAdMobAndroid.hasCachedBanner () then
    	print ( "Showing AdMob banner." )
        MOAIAdMobAndroid.showBanner ()
    else
    	print ( "There is no cached banner." )
    end
end )
