local composer = require( "composer" )
local scene = composer.newScene()
local sceneGroup 

local image, text1, text2  

local function onSceneTouch( self, event )
	if event.phase == "began" then
		if (event.x>display.contentCenterX) then		
		nextpage="begin"
		prevpage="current"
		P=P+1
		if (P>PAGE) then
		 P=1
   		 section=section+1
                if (section>TOTAL)then
                        section=1
                end
		end
		composer.gotoScene( nextpage, "slideLeft", 800  )
		else
		nextpage="current"
		prevpage="begin"
		P=P-1
		if (P<1) then
		P=2
 		section=section-1
                if (section<1)then
                        section=TOTAL
                end
		end
		composer.gotoScene( nextpage, "slideRight", 800  )

		end	
		
		return true
	end
end


-- Called when the scene's view does not exist:
--http://stackoverflow.com/questions/21073486/attempt-to-index-global-group-a-nil-value-lua
function scene:create( event )
	sceneGroup = self.view
	image = display.newImage( "lotus.jpg" )
	image.x = display.contentCenterX
	image.y = display.contentCenterY
		image.height=DISPLAYHEIGHT
	image.width=DISPLAYWIDTH
	sceneGroup:insert( image )
	image.touch = onSceneTouch
	
end

function scene:show( event )
	local phase = event.phase
	
	if "did" == phase then
	
		composer.removeScene( prevpage)
		local showMem = function()
			--if not image then
			--	image:addEventListener( "touch", image )
			--else
				image = display.newImage( "lotus.jpg" )
				image.x = display.contentCenterX
				image.y = display.contentCenterY
					image.height=DISPLAYHEIGHT
	image.width=DISPLAYWIDTH
				image:addEventListener( "touch", image )
				sceneGroup:insert( image )
				image.touch = onSceneTouch
			--	sceneGroup:insert( text1 )
				sceneGroup:insert( text2 )
				--sceneGroup:insert( text3 )
			--end
		end
		memTimer = timer.performWithDelay( 0, showMem, 1 )
	--local sceneGroup = self.view
	
	   local options =
{
    text = a[section][2],
    x = display.contentWidth/2-y0,
    y = yt,
    width = display.contentWidth*ratiot,
    font = native.systemFont,
    fontSize = fontsize,
    align = "center"  -- Alignment parameter
}
-- text1 = display.newText( options )
--text1:setFillColor( text_R,text_G,text_B )

      --  sceneGroup:insert( text1 )


 local options1 =
{
    text =  a[section][2] .. "\n\n" ..string.gsub( a[section][3+P], "NEWLINE", "\n\n" ),
    x = display.contentWidth/2,
    y = display.contentHeight/2-y1,
    width = display.contentWidth*ratiot,
    font = native.systemFont,
    fontSize = fontsize,
    align = "center"  -- Alignment parameter
}
        text2 = display.newText( options1 )

        text2:setFillColor( text_R,text_G,text_B)

        sceneGroup:insert( text2 )


	end
end

function scene:hide( event )
	
	local phase = event.phase
	
	if "will" == phase then
	
		image:removeEventListener( "touch", image )
	
		timer.cancel( memTimer ); memTimer = nil;
	
	--local sceneGroup = self.view
--	sceneGroup:remove( text1 )
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
