
local classColor = RAID_CLASS_COLORS[select(2, UnitClass('player'))]

MinimapToggleButton:Hide()

--Hide Minimap Clock
local mm = CreateFrame("Frame", "DejaMinimapFrame")

	mm:RegisterEvent("PLAYER_LOGIN")
	mm:RegisterEvent("PLAYER_ENTERING_WORLD")
	mm:RegisterEvent("ADDON_LOADED")
	mm:RegisterEvent("UPDATE_INSTANCE_INFO")

local function eventHandler(self, event, ...)
	for i = 1, 1 do
		if TimeManagerClockButton then
			TimeManagerClockButton:SetAlpha(0)
		end
	end
end

mm:SetScript("OnEvent",eventHandler)

-- Create New Minimap Clock

local use24hformat = true

local mmclock = CreateFrame("Frame", nil, Minimap)
	mmclock:RegisterEvent("PLAYER_LOGIN")
	mmclock:RegisterEvent("PLAYER_ENTERING_WORLD")
	mmclock:RegisterEvent("ADDON_LOADED")
	mmclock:RegisterEvent("PLAYER_REGEN_DISABLED")
	mmclock:RegisterEvent("PLAYER_REGEN_ENABLED")
	mmclock:RegisterEvent("UNIT_COMBAT")

	mmclock:SetFrameStrata("MEDIUM")
	mmclock:SetFrameLevel("9")
	mmclock:SetWidth(40)
	mmclock:SetHeight(18)
	mmclock:SetPoint("BOTTOM", Minimap, "BOTTOM", 0, 5)
	mmclock:Show()

local clockFS = mmclock:CreateFontString("FontString","OVERLAY","GameTooltipText")

	clockFS:SetPoint("BOTTOM",mmclock,"BOTTOM",0,0)

local elapsed = 0
	mmclock:SetScript("OnUpdate", function(self, e)
	   elapsed = elapsed + e
	   if elapsed >= 1 then
		   MinimapClockRefresh()
		   elapsed = 0
	   end
end)

	mmclock:SetScript("OnEvent", function()
		clockFS:SetTextColor(1, 1, 1);
		MinimapClockRefresh()
	end)
	
function MinimapClockRefresh()
	clockFS:SetFont('Fonts\\ARIALN.ttf', 15, 'OUTLINE')
	if use24hformat then
		clockFS:SetText(date("%H:%M"))
	else
		clockFS:SetText(("%d:%s"):format(tonumber(date("%I")),((date("%M%p")))))
	end
	clockFS:SetTextColor(classColor.r, classColor.g, classColor.b)
	clockFS:SetShadowOffset(0, 0)
end