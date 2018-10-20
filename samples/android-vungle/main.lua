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

    MOAIVungleAndroid.setListener (
        MOAIVungleAndroid.REWARDED_VIDEO_COMPLETED,
        function ()
            print ( 'Rewarded video successfully completed.' )
        end
    )

    MOAIVungleAndroid.init ( '< YOUR APP ID >', '< YOUR PLACEMENT ID >' )

    MOAICoroutine.blockOnAction ( delay_timer:start () )
    coroutine:yield ()

    MOAIVungleAndroid.cacheRewardedVideo ()

    MOAICoroutine.blockOnAction ( delay_timer:start () )
    coroutine:yield ()

    if MOAIVungleAndroid.hasCachedRewardedVideo () then
    	print ( 'Showing Vungle rewarded video.' )
        MOAIVungleAndroid.showRewardedVideo ()
    else
    	print ( 'There is no cached rewarded video.' )
    end
end )
