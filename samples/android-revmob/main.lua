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
    local delay_timer = MOAITimer:new ()
    delay_timer:setSpan ( 10 )

    MOAICoroutine.blockOnAction ( delay_timer:start () )
    coroutine:yield ()

    MOAIRevMobAndroid.setListener (
        MOAIRevMobAndroid.REWARDED_VIDEO_COMPLETED,
        function ()
            print ( "Rewarded video successfully completed." )
        end
    )

    MOAIRevMobAndroid.init ( '< YOUR APP ID >' )

    MOAICoroutine.blockOnAction ( delay_timer:start () )
    coroutine:yield ()

    MOAIRevMobAndroid.cacheInterstitial ( '< YOUR PLACEMENT ID >' )
    MOAIRevMobAndroid.cacheRewardedVideo ( '< YOUR PLACEMENT ID >' )

    MOAICoroutine.blockOnAction ( delay_timer:start () )
    coroutine:yield ()

    if MOAIRevMobAndroid.hasCachedInterstitial ( '< YOUR PLACEMENT ID >' ) then
    	print ( "Showing RevMob interstitial." )
        MOAIRevMobAndroid.showInterstitial ( '< YOUR PLACEMENT ID >' )
    else
    	print ( "There is no cached interstitial." )
    end

    MOAICoroutine.blockOnAction ( delay_timer:start () )
    coroutine:yield ()

    if MOAIRevMobAndroid.hasCachedRewardedVideo ( '< YOUR PLACEMENT ID >' ) then
    	print ( "Showing RevMob rewarded video." )
        MOAIRevMobAndroid.showRewardedVideo ( '< YOUR PLACEMENT ID >' )
    else
    	print ( "There is no cached rewarded video." )
    end
end )
