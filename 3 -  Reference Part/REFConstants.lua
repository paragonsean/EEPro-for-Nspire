
RefConstants = Screen()

RefConstants.data = {
{"Pi",utf8(960).." or pi","3.14159..."},
{"Euler's number","e","2.71828..."},
}

RefConstants.tmpScroll = 1
RefConstants.leftRight = 1

function RefConstants:arrowKey(arrw)
	if arrw == "up" then
		RefConstants.tmpScroll = RefConstants.tmpScroll - test(RefConstants.tmpScroll>1)
	end
	if arrw == "down" then
		RefConstants.tmpScroll = RefConstants.tmpScroll + test(RefConstants.tmpScroll<(table.getn(RefConstants.data)-7))
	end
	if arrw == "left" then
		RefConstants.leftRight = RefConstants.leftRight - 5*test(RefConstants.leftRight>1)
	end
	if arrw == "right" then
		RefConstants.leftRight = RefConstants.leftRight + 5*test(RefConstants.leftRight<150)
	end
	screenRefresh()
end

function RefConstants:paint(gc)
	gc:setColorRGB(255,255,255)
	gc:fillRect(self.x, self.y, self.w, self.h)
	gc:setColorRGB(0,0,0)
	
	    msg = "Constants : "
        gc:setFont("sansserif","b",12)
        if RefConstants.leftRight > 1 then
        	gc:drawString(utf8(9664),4,0,"top")
        end
        if RefConstants.leftRight < 160 then
        	gc:drawString(utf8(9654),pww()-gc:getStringWidth(utf8(9660))-2,0,"top")
        end
        if RefConstants.tmpScroll > 1 then
        	gc:drawString(utf8(9650),gc:getStringWidth(utf8(9664))+7,0,"top")
        end
        if RefConstants.tmpScroll < table.getn(RefConstants.data)-7 then
        	gc:drawString(utf8(9660),pww()-4*gc:getStringWidth(utf8(9654))-2,0,"top")
        end
        drawXCenteredString(gc,msg,4)
        gc:setFont("sansserif","r",12)
        
       	local tmp = 0
       	for k=RefConstants.tmpScroll,table.getn(RefConstants.data) do
			tmp = tmp + 1
       		gc:setFont("sansserif","b",12)
            gc:drawString(RefConstants.data[k][1], 5-RefConstants.leftRight, 5+22*tmp, "top")
        	gc:setFont("sansserif","r",12)
            gc:drawString("  (" .. RefConstants.data[k][2] .. ") : " .. RefConstants.data[k][3] .. ". ", gc:getStringWidth(RefConstants.data[k][1])+15-RefConstants.leftRight, 5+22*tmp, "top")
		end
end

function RefConstants:escapeKey()
	only_screen_back(Ref)
end

