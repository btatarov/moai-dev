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

MOAITwitterAndroid.setListener (
        MOAITwitterAndroid.SESSION_DID_LOGIN,
        function ()
            MOAITwitterAndroid.sendTweet ( 'Shamelessly tweeting from MOAI. #moaidev' )
        end
)

MOAITwitterAndroid.setListener (
        MOAITwitterAndroid.SESSION_DID_NOT_LOGIN,
        function ()
            print ( 'Twitter was unable to login.' )
        end
)

MOAITwitterAndroid.setListener (
        MOAITwitterAndroid.TWEET_SUCCESSFUL,
        function ()
            print ( 'Tweet successfully published.' )
        end
)

-- MOAITwitterAndroid.init ( '< CONSUMER KEY >', '< CONSUMER SECRET >', '< CALLBACK URL >' )
MOAITwitterAndroid.init ( 'ySzVb8xcINBm5he1obavw', 'xHwY0522QCKF2QlibvFwCn882WWlEGiNcVU1VYZud8c', 'http://www.mahjongskies.com/' )
MOAITwitterAndroid.login ()
