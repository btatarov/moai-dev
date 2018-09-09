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

MOAIRevMobIOS.setListener ( MOAIRevMobIOS.REWARDED_VIDEO_COMPLETED, function ()

	print ( 'Rewarded video successfully completed. You can have your award now.' )
end )

MOAIRevMobIOS.init ( '< YOUR APP ID >' )
MOAIRevMobIOS.initBannerWithParams ( 20, screenWidth - 20, 0, true )

-- wait 10 seconds between interactions
local thread = MOAICoroutine.new ()

thread:run( function ()
	local delay_timer = MOAITimer:new ()
	delay_timer:setSpan ( 10 )

	MOAIRevMobIOS.cacheBanner ()
	MOAIRevMobIOS.cacheInterstitial ()
	MOAIRevMobIOS.cacheRewardedVideo ()

	MOAICoroutine.blockOnAction ( delay_timer:start () )
	coroutine:yield ()

	if MOAIRevMobIOS.hasCachedBanner () then
		print ( 'Showing AdMob banner.' )
		MOAIRevMobIOS.showBanner ()
	else
		print ( 'There is no cached banner.' )
	end

	MOAICoroutine.blockOnAction ( delay_timer:start () )
	coroutine:yield ()

	if MOAIRevMobIOS.hasCachedInterstitial () then
		print ( 'Showing Admob interstitial.' )
		MOAIRevMobIOS.showInterstitial ()
	else
		print ( 'There is no cached interstitial.' )
	end

	MOAICoroutine.blockOnAction ( delay_timer:start () )
	coroutine:yield ()

	if MOAIRevMobIOS.hasCachedRewardedVideo () then
		print ( 'Showing Admob rewarded video.' )
		MOAIRevMobIOS.showRewardedVideo ()
	else
		print ( 'There is no cached rewarded video.' )
	end

	MOAICoroutine.blockOnAction ( delay_timer:start () )
	coroutine:yield ()

	print ( 'Hiding AdMob banner.' )
	MOAIRevMobIOS.hideBanner ()
end )
