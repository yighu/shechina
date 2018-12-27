
require "sqlite3"
text_R=230/255
text_G=230/255
text_B=230/255

a={}
b={}
a[1]={}
a[1][1]=233
a[1][2]="敬拜尊崇"
a[1][3]="停下来，向神表述你个人的赞美和敬拜之意"
a[2]={}
a[2][1]=342
a[2][2]="认罪悔改"
a[2][3]="祈求圣灵鉴察看你内心，显明任何还没有认的罪。向主承认这些过犯，感谢他赦免你的罪。"
a[3]={}
a[3][1]=516
a[3][2]="恢复更新"
a[3][3]="停下来，加上你自己个人更新的祷告。"
a[4]={}
a[4][1]=370
a[4][2]="个人祈求"
a[4][3]="停下来请求神赐给你恩典成长敬虔的品格"
a[5]={}
a[5][1]=203
a[5][2]="彼此代求"
a[5][3]="停下来反思你同他人的关系，并将他们交托给神"

a[6]={}
a[6][1]=203
a[6][2]="信靠顺服"
a[6][3]="停下来，反思这些圣经给我们的确据。"

a[7]={}
a[7][1]=203
a[7][2]="感恩"
a[7][3]="停下来，献上你自己的感恩之意"

a[8]={}
a[8][1]=203
a[8][2]="结束祷告"
a[8][3]=""
TOTAL=8
PAGE=2
y0=0
y1=50
yt=0
y2=200
DISPLAYWIDTH=800
DISPLAYHEIGHT=1400
fontsize=32
titley0=50
titley1=600
ratiow=1.8
ratiot=0.8
section=1
P=1
nextpage="current"
prevpage="end"

function doesFileExist( fname, path )

    local results = false

    local filePath = system.pathForFile( fname, path )

    --filePath will be 'nil' if file doesn't exist and the path is 'system.ResourceDirectory'
    if ( filePath ) then
        filePath = io.open( filePath, "r" )
    end

    if ( filePath ) then
        --print( "File found: " .. fname )
        --clean up file handles
        filePath:close()
        results = true
    else
        print( "File does not exist: " .. fname )
    end

    return results
end
function copyFile( srcName, srcPath, dstName, dstPath, overwrite )

    local results = false

    local srcPath = doesFileExist( srcName, srcPath )

    if ( srcPath == false ) then
        return nil  -- nil = source file not found
    end

    --check to see if destination file already exists
    if not ( overwrite ) then
        if ( doesFileExist( dstName, dstPath ) ) then
            return 1  -- 1 = file already exists (don't overwrite)
        end
    end

    --copy the source file to the destination file
    local rfilePath = system.pathForFile( srcName, srcPath )
    local wfilePath = system.pathForFile( dstName, dstPath )

    local rfh = io.open( rfilePath, "rb" )
    local wfh = io.open( wfilePath, "wb" )

    if not ( wfh ) then
        print( "writeFileName open error!" )
        return false
    else
        --read the file from 'system.ResourceDirectory' and write to the destination directory
        local data = rfh:read( "*a" )
        if not ( data ) then
            print( "read error!" )
            return false
        else
            if not ( wfh:write( data ) ) then
                print( "write error!" )
                return false
            end
        end
    end

    results = 2  -- 2 = file copied successfully!

    --clean up file handles
    rfh:close()
    wfh:close()

    return results
end


setVerse=function()
local linenumber=tostring(math.random(1,92))
local QRY="SELECT * FROM pray where id="..linenumber.." and bky='ChiUNs'"
local result=copyFile( "f2f.db", system.ResourceDirectory, "f2f.db", system.DocumentsDirectory,false)
--print ("result..."..result)
local path = system.pathForFile("f2f.db", system.DocumentsDirectory)
local db = sqlite3.open( path )   
for row in db:nrows(QRY) do
  a[1][4]= row.ptxt
  a[1][5]= row.pcmt
  a[2][4]= row.ctxt
  a[2][5]= row.ccmt
  a[3][4]= row.rtxt
  a[3][5]= row.rcmt
  a[4][4]= row.ttxt
  a[4][5]= row.tcmt
  a[5][4]= row.itxt
  a[5][5]= row.icmt
  a[6][4]= row.atxt
  a[6][5]= row.acmt
  a[7][4]= row.ntxt
  a[7][5]= row.ncmt
  a[8][4]= row.ltxt
  a[8][5]= ""  
end
end


setVerse()
--[[
touchtocontinue="按一下屏幕继续"
	text3 = display.newText( touchtocontinue, 0, 0, native.systemFontBold, 36 )
	text3:setFillColor( 255 ); 
	text3.isVisible = true
	text3.x, text3.y = display.contentWidth * 0.5, display.contentHeight - 50
--]]
display.setStatusBar( display.HiddenStatusBar )

local composer = require "composer"

local widget = require "widget"

composer.gotoScene( "begin", "fade", 400 )

local tabButtons = 
{

	{ 
	
		label = "祷告",
		id="prayer",
		labelColor = { over={ 0, 0, 0 }, default={ 0, 0, 0, 0.5 } },
		size=fontsize,
    onPress = function() composer.gotoScene( "begin" ); end, 

		selected = true,

	},
	
	{ 
		label = "刷新",
		id="reset",
		labelColor = { over={ 0, 0, 0 }, default={ 0, 0, 0, 0.5 } },
		size=fontsize,
    		onPress = function () 
				setVerse()
				section=1
				P=1
    			composer.gotoScene( "begin","fade",400 )
    		
		 end, 

	},
	{ 
		
		label = "信息",
		id="info",
		labelColor = { over={ 0, 0, 0 }, default={ 0, 0, 0, 0.5 } },
		size=fontsize,
    onPress = function() composer.gotoScene( "info" ); end, 
	}
--[[	,
	{ 
		width = 32,
		height = 32,
		defaultFile = "icon2.png",
		overFile = "icon2-down.png",
		label = "分享",
    		onPress = function() composer.gotoScene( "sharing" ); end, 
	}
	--]]
}

local tabBar = widget.newTabBar
{
	top = 0,
	--display.contentHeight,
	width = display.contentWidth,
	height=40,
	
	--[[
	backgroundFile = "tabbar.png",
	tabSelectedLeftFile = "tabBar_tabSelectedLeft.png",
	tabSelectedMiddleFile = "tabBar_tabSelectedMiddle.png",
	tabSelectedRightFile = "tabBar_tabSelectedRight.png",
	--]]
	tabSelectedFrameWidth = 40,
	tabSelectedFrameHeight = 40,
	buttons = tabButtons
}

-- hit 'c' to capture your screen
--[[local function cap(event)
    if event.keyName== "c" and event.phase == "up" then
        local screenCap = display.captureScreen( true )
        display.remove (screenCap)
        screenCap = nil
    end
    return true
end
 
Runtime:addEventListener("key",cap)
--]]
-- hit 'c' to capture your screen
