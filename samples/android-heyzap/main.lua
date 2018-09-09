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

-- wait 15 seconds between interactions
local thread = MOAICoroutine.new ()
thread:run( function ()
    local delay_timer = MOAITimer:new ()
    delay_timer:setSpan ( 15 )

    MOAICoroutine.blockOnAction ( delay_timer:start () )
    coroutine:yield ()

    MOAIHeyZapAndroid.setListener (
        MOAIHeyZapAndroid.REWARDED_VIDEO_COMPLETED,
        function ()
            print ( "Rewarded video successfully completed." )
        end
    )

    local AMAZON_STORE = false
    MOAIHeyZapAndroid.init ( '< YOUR PUBLISHER ID >', AMAZON_STORE )

    MOAICoroutine.blockOnAction ( delay_timer:start () )
    coroutine:yield ()

    MOAIHeyZapAndroid.cacheInterstitial ()
    MOAIHeyZapAndroid.cacheRewardedVideo ()

    MOAICoroutine.blockOnAction ( delay_timer:start () )
    coroutine:yield ()

    if MOAIHeyZapAndroid.hasCachedInterstitial () then
    	print ( "Showing HeyZap interstitial." )
        MOAIHeyZapAndroid.showInterstitial ()
    else
    	print ( "There is no cached interstitial." )
    end

    MOAICoroutine.blockOnAction ( delay_timer:start () )
    coroutine:yield ()

    if MOAIHeyZapAndroid.hasCachedRewardedVideo () then
    	print ( "Showing HeyZap rewarded video." )
        MOAIHeyZapAndroid.showRewardedVideo ()
    else
    	print ( "There is no cached rewarded video." )
    end
end )
