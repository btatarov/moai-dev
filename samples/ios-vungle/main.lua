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
    MOAIVungleIOS.setListener ( MOAIVungleIOS.REWARDED_VIDEO_COMPLETED, function ()

    	print ( 'Rewarded video successfully completed. You can have your award now.' )
    end )

    local delay_timer = MOAITimer:new ()
    delay_timer:setSpan ( 10 )

    local placements = { '< YOUR PLACEMENT ID >' }
    MOAIVungleIOS.init ( '< YOUR UNIT ID >', placements )

    MOAICoroutine.blockOnAction ( delay_timer:start () )
    coroutine:yield ()

    -- Call this only for non-automatic placements
    -- MOAIVungleIOS.cacheRewardedVideo ( placements[1] )
    --
    -- MOAICoroutine.blockOnAction ( delay_timer:start () )
    -- coroutine:yield ()

    if MOAIVungleIOS.hasCachedRewardedVideo ( placements[1] ) then
    	print ( 'Showing Vungle video ad.' )
        MOAIVungleIOS.showRewardedVideo ( placements[1] )
    else
    	print ( 'There is no cached video ad.' )
    end
end )
