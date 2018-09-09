MOAISim.openWindow ( 'test', 320, 480 )

viewport = MOAIViewport.new ()
viewport:setSize ( 320, 480 )
viewport:setScale ( 320, 480 )

layer = MOAILayer2D.new ()
layer:setViewport ( viewport )
MOAISim.pushRenderPass ( layer )

gfxQuad = MOAIGfxQuad2D.new ()
gfxQuad:setTexture ( 'moai.png' )
gfxQuad:setRect ( -64, -64, 64, 64 )

prop = MOAIProp2D.new ()
prop:setDeck ( gfxQuad )
layer:insertProp ( prop )

prop:moveRot ( 720, 2.0 )

MOAIFacebookIOS.setListener (
    MOAIFacebookIOS.LOGIN_SUCCESSFUL,
    function ()
        print ( 'Done logging in. Trying to post something.' )

        local url = 'http://getmoai.com/'
        local img = 'http://getmoai.com/images/getmoai/moaiattribution_horiz_black.png'
        local caption = 'Moai SDK'
        local description = 'Quick test to see if Facebook posting works.'

        MOAIFacebookIOS.postToFeed ( url, img, caption, description )
    end
)

MOAIFacebookIOS.setListener (
    MOAIFacebookIOS.SHARE_SUCCESSFUL,
    function ()
        print ( 'Post successful.' )

        local url = '< URL TO YOUR APP ON ITUNES >'
        local img = 'http://getmoai.com/images/getmoai/moaiattribution_horiz_black.png'

        MOAIFacebookIOS.inviteFriends ( url, img )
    end
)

-- wait 5 seconds before logging in
local thread = MOAICoroutine.new ()

thread:run ( function ()
    local delay_timer = MOAITimer:new ()
    delay_timer:setSpan ( 5 )

    MOAICoroutine.blockOnAction ( delay_timer:start () )
    coroutine:yield ()

    MOAIFacebookIOS.login ()
end )
