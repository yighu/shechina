local composer = require( "composer" )
local scene = composer.newScene()
local sceneGroup 

local image, text1, text2  

local function onSceneTouch( self, event )
print("to onSceneTouch")
print(event.phase)
if event.phase == "began" then
		
		
		if (event.x>display.contentCenterX) then		
		nextpage="prayscript11"
		prevpage="prayscript11"
		section=section+1
		if(section>5) then
			section=1
			end
		composer.gotoScene( nextpage, "slideLeft", 800  )
		else
		nextpage="prayscript11"
		prevpage="prayscript11"
		section=section-1
		if(section<1) then
			section=5
			end
		composer.gotoScene( nextpage, "slideRight", 800  )
		end	
		return true
	end
	
end


-- Called when the scene's view does not exist:
--http://stackoverflow.com/questions/21073486/attempt-to-index-global-group-a-nil-value-lua
function scene:create( event )
print("to create")

	print(phase)
	sceneGroup = self.view
	image = display.newImage( "bg.jpg" )
	image.x = display.contentCenterX
	image.y = display.contentCenterY
	sceneGroup:insert( image )
	image.touch = onSceneTouch
	
end

function scene:show( event )
	local phase = event.phase
	print("to show")

	print(phase)

	if "did" == phase then
	
		composer.removeScene( prevpage)
		
		
		local showMem = function()
			--if (image ~= nil) then
			--	image:addEventListener( "touch", image )
			--else
				image = display.newImage( "bg.jpg" )
				image.x = display.contentCenterX
				image.y = display.contentCenterY
		   	    image:addEventListener( "touch", image )
		 		sceneGroup:insert( image )

		    --end
		end
			
		image.touch = onSceneTouch
		--memTimer = timer.performWithDelay( 1000, showMem, 1 )
		showMem()
		
		local options = 
{
    text = a[section][2],     
    x = display.contentWidth/2-50,
    y = 50,
    width = display.contentWidth*ratiot,
    font = native.systemFont,   
    fontSize = 36,
    align = "center"  -- Alignment parameter
}
 text1 = display.newText( options )
text1:setFillColor( text_R,text_G,text_B )
	
	sceneGroup:insert( text1 )
	
		local options1 = 
{
    text =  string.gsub( a[section][4], "NEWLINE", "\n\n" ),     
    x = display.contentWidth/2,
    y = display.contentHeight/2-200,
    width = display.contentWidth*ratiot,
    font = native.systemFont,   
    fontSize = 28,
    align = "center"  -- Alignment parameter
}
	text2 = display.newText( options1 ) 

	text2:setFillColor( text_R,text_G,text_B)
	
	sceneGroup:insert( text2 )
			
		end
	end
		
	--local sceneGroup = self.view
	
	

function scene:hide( event )
	
	local phase = event.phase
	print("to hide")
	print(phase)
	if "will" == phase then
	
		--image:removeEventListener( "touch", image )
	
		--timer.cancel( memTimer ); memTimer = nil;
	
	--local sceneGroup = self.view
	sceneGroup:remove( text1 )
	sceneGroup:remove( text2 )
	
	end
	
end

function scene:destroy( event )
end



scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )


return scene
