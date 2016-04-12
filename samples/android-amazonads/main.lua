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

    MOAIAmazonAdsAndroid.init ( '< YOUR APP KEY >' )
    MOAIAmazonAdsAndroid.initBannerWithParams ( 470, 0, 10, true )

    MOAIAmazonAdsAndroid.cacheBanner ()
    MOAIAmazonAdsAndroid.cacheInterstitial ()

    MOAICoroutine.blockOnAction ( delay_timer:start () )
    coroutine:yield ()

    if MOAIAmazonAdsAndroid.hasCachedInterstitial () then
    	print ( "Showing AmazonAds interstitial." )
        MOAIAmazonAdsAndroid.showInterstitial ()
    else
    	print ( "There is no cached interstitial." )
    end

    MOAICoroutine.blockOnAction ( delay_timer:start () )
    coroutine:yield ()

    if MOAIAmazonAdsAndroid.hasCachedBanner () then
    	print ( "Showing AmazonAds banner." )

        MOAIAmazonAdsAndroid.showBanner ()

        -- flick banner
        MOAICoroutine.blockOnAction ( delay_timer:start () )
        coroutine:yield ()

        print ( "Hiding and recaching banner." )
        MOAIAmazonAdsAndroid.hideBanner ()
        MOAIAmazonAdsAndroid.cacheBanner ()

        MOAICoroutine.blockOnAction ( delay_timer:start () )
        coroutine:yield ()

        if MOAIAmazonAdsAndroid.hasCachedBanner () then
            print ( "Showing banner again" )
            MOAIAmazonAdsAndroid.showBanner ()
        else
            print ( "Unable to cache second banner." )
        end
    else
    	print ( "There is no cached banner." )
    end
end )
