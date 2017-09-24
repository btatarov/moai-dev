MOAISim.openWindow ( "test", 320, 480 )

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
    MOAIAdColonyIOS.setListener ( MOAIAdColonyIOS.REWARDED_VIDEO_COMPLETED, function ()

    	print ( 'Rewarded video successfully completed. You can have your award now.' )
    end )

    local delay_timer = MOAITimer:new ()
    delay_timer:setSpan ( 10 )

    local zones = { '< YOUR ZONE ID >' }
    MOAIAdColonyIOS.init ( '< YOUR APP ID >', zones )

    MOAICoroutine.blockOnAction ( delay_timer:start () )
    coroutine:yield ()
    
    MOAIAdColonyIOS.cacheRewardedVideo ( zones[1] )

    MOAICoroutine.blockOnAction ( delay_timer:start () )
    coroutine:yield ()

    if MOAIAdColonyIOS.hasCachedRewardedVideo () then
    	print ( 'Showing AdColony video ad.' )
        MOAIAdColonyIOS.showRewardedVideo ()
    else
    	print ( 'There is no cached video ad.' )
    end
end )
