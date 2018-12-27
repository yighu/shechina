local composer = require( "composer" )
local scene = composer.newScene()
local sceneGroup 

local image, text1, text2
local lotsOfText ="祷告是基督徒的权力和义务。生命的成长离不开祷告。圣经教导我们要常常祷告。圣经中记载了无数的祷告。神听我们的祷告。耶稣基督也在天上为我们祷告。读经需要祷告，让圣灵带领并开启我们心灵的眼睛，使我们能听到并明白神所要教导我们的。另一方面，读经过程中，神的话会感动我们，有的让我们看到自己的罪，有的让我们看到人们需要主，有的鼓舞我们对神的信心，有的让我们感谢赞美神。这些都可以带到主面前。所以有一种祷告方式叫祷告圣经。就是将神的话向神祷告回去，同时领会神的话对我们的提醒，再向神摆上我们自己的赞美，祈求和感恩。此软件就是为此而作。此程序偏重灵命成长通过祷告神的话。 \n\n内容根据<<Hand Book To Renewal>>(Kenneth Boa)翻译编集而成。 \n\n此程序由胡益光弟兄和陈彪博士（牧师）合作完成。"

local function onSceneTouch( self, event )
	if event.phase == "began" then
		if (event.x>display.contentCenterX) then		
		nextpage="end"
		prevpage="begin"
		P=P+1
		if (P>PAGE) then
		 P=1
   		 section=section+1
                if (section>TOTAL)then
                        section=1
                        setVerse()
                end
		end
		composer.gotoScene( nextpage, "slideLeft", 800  )
		else
		nextpage="begin"
		prevpage="end"
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


	image = display.newImage( "banboocut.jpg" )
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
	
		if prevpage ~= "begin"  then 
		  composer.removeScene( prevpage)
		end
		local showMem = function()
			--if not image then
			--	image:addEventListener( "touch", image )
			--else
				image = display.newImage( "banboocut.jpg" )
				image.x = display.contentCenterX
				image.y = display.contentCenterY
				image.height=DISPLAYHEIGHT
				image.width=DISPLAYWIDTH
				image:addEventListener( "touch", image )
				sceneGroup:insert( image )
				image.touch = onSceneTouch
				sceneGroup:insert( text1 )
				sceneGroup:insert( text2 )
				--sceneGroup:insert( text3 )
			--end
		end
		memTimer = timer.performWithDelay( 0, showMem, 1 )
	--local sceneGroup = self.view
	
	   local options =
{
    text = " ",
    x = display.contentWidth/2-y0,
    y = yt,
    width = display.contentWidth*ratiot,
    font = native.systemFont,
    fontSize = fontsize,
    align = "center"  -- Alignment parameter
}
 text1 = display.newText( options )
text1:setFillColor( text_R,text_G,text_B )

        sceneGroup:insert( text1 )


 local options1 =
{

    text =   "使用说明\n"..lotsOfText,
    x = display.contentWidth/2,
    y = display.contentHeight/2-y1+20,
    width = display.contentWidth*ratiot,
    font = native.systemFont,
    fontSize = fontsize-2,
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
