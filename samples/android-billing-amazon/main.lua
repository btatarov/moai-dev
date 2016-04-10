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

local spend_some_greens = function ()

    -- wait 5 seconds between interactions
    local thread = MOAICoroutine.new ()
    thread:run( function ()

        local delay_timer = MOAITimer:new ()
        delay_timer:setSpan ( 5 )

        MOAIBillingAndroid.requestPurchase ( 'com.moai.sample.test_sku' )

        MOAICoroutine.blockOnAction ( delay_timer:start () )
        coroutine:yield ()

        MOAIBillingAndroid.restoreTransactions ()
    end )
end

MOAIBillingAndroid.setListener ( MOAIBillingAndroid.CHECK_BILLING_SUPPORTED, function ( supported )

    if supported then

        print ( 'billing support available.' )
    else

        print ( 'billing support not available.' )
    end
end)

MOAIBillingAndroid.setListener ( MOAIBillingAndroid.USER_ID_DETERMINED, function ( responseCode, userId )

    if responseCode == MOAIBillingAndroid.BILLING_RESULT_SUCCESS then

        print ( 'user id determined: ' .. userId )
        spend_some_greens ()
    else

        print ( 'user id request failed.' )
    end
end)

MOAIBillingAndroid.setListener ( MOAIBillingAndroid.PURCHASE_RESPONSE_RECEIVED, function ( responseCode, sku )

    if responseCode == MOAIBillingAndroid.BILLING_RESULT_SUCCESS then

        print ( sku .. ' purchase successful!' )
    else

        print ( sku .. ' purchase failed.' )
    end
end )

MOAIBillingAndroid.setListener ( MOAIBillingAndroid.RESTORE_RESPONSE_RECEIVED, function ( responseCode, hasMore, sku )

    if responseCode == MOAIBillingAndroid.BILLING_RESULT_SUCCESS then

        print ( 'you have a purchase with sku: ' .. sku )
    else

        print ( 'restoring purchases failed.' )
    end
end )

MOAIBillingAndroid.setBillingProvider ( MOAIBillingAndroid.BILLING_PROVIDER_AMAZON )
