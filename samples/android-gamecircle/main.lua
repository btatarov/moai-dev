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

MOAIGameCircleAndroid.setListener (
		MOAIGameCircleAndroid.SERVICE_READY,
		function ()
			print ( 'GameCircle service is ready now.' )

			-- HACK: unset the listener because onResume will call .connect () again
			MOAIGameCircleAndroid.setListener ( MOAIGameCircleAndroid.SERVICE_READY, nil )
			MOAIGameCircleAndroid.showDefaultLeaderboard ()
		end
)

-- HINT: Usually GameCircle automatically connects on start so invoke connect()
-- only if you need it later in the game. It's safe to call it more than once.
if not MOAIGameCircleAndroid.isConnected () then
	print ( 'GameCircle service is not ready yet. Trying to connect...' )
	MOAIGameCircleAndroid.connect ()
else
	print ( 'GameCircle service is already connected.' )
	MOAIGameCircleAndroid.showDefaultLeaderboard ()
end
