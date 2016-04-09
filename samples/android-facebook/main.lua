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

MOAIFacebookAndroid.setListener (
    MOAIFacebookAndroid.FACEBOOK_LOGIN_SUCCESS,
    function ()
        print ( "Done logging in. Trying to post something." )

        local url = "http://getmoai.com/"
        local img = "http://getmoai.com/images/getmoai/moaiattribution_horiz_black.png"
        local caption = "Moai SDK"
        local description = "Quick test to see if Facebook posting works."

        MOAIFacebookAndroid.postToFeed ( url, img, caption, description )
    end
)

MOAIFacebookAndroid.setListener (
    MOAIFacebookAndroid.FACEBOOK_DIALOG_SUCCESS,
    function ()
        print ( "Post successful." )
    end
)

MOAIFacebookAndroid.login ()
