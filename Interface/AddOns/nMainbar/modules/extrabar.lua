
local addonName, addonTable = ...
local _, nMainbar = ...
local cfg = nMainbar.Config

if (not cfg.extraBar.enabled) then
    return
end

BINDING_HEADER_EXTRABAR = "ExtraBar"
BINDING_NAME_EXTRABARBUTTON1 = "Button 1"
BINDING_NAME_EXTRABARBUTTON2 = "Button 2"
BINDING_NAME_EXTRABARBUTTON3 = "Button 3"
BINDING_NAME_EXTRABARBUTTON4 = "Button 4"
BINDING_NAME_EXTRABARBUTTON5 = "Button 5"
BINDING_NAME_EXTRABARBUTTON6 = "Button 6"
BINDING_NAME_EXTRABARBUTTON7 = "Button 7"
BINDING_NAME_EXTRABARBUTTON8 = "Button 8"
BINDING_NAME_EXTRABARBUTTON9 = "Button 9"
BINDING_NAME_EXTRABARBUTTON10 = "Button 10"
BINDING_NAME_EXTRABARBUTTON11 = "Button 11"
BINDING_NAME_EXTRABARBUTTON12 = "Button 12"

addonTable.Funcs = {}

local MyFuncs = addonTable.Funcs

local f = CreateFrame("Frame", nil, UIParent)

function MyFuncs.OnEvent(self, event, ...)
	if event == "ACTIONBAR_PAGE_CHANGED" then
		if GetActionBarPage() ~= 1 then	ChangeActionBarPage(1) end
	elseif event == "UPDATE_BINDINGS" then
		MyFuncs.UpdateBindings()
	elseif event == "PLAYER_LOGIN" then
		
	end
end

function MyFuncs.UpdateBindings()
	for i=1,12,1 do
		local button = _G["ExtraBarButton"..i]
		local id = button:GetID()

		local hotkey = _G[button:GetName().."HotKey"]
		local key = GetBindingKey("EXTRABARBUTTON"..i)
		local text = GetBindingText(key, "KEY_", 1)

		if text == "" then
			hotkey:SetText(RANGE_INDICATOR)
			hotkey:SetPoint("TOPLEFT", button, "TOPLEFT", 1, -2)
			hotkey:Hide()
		else
			hotkey:SetText(text)
			hotkey:SetPoint("TOPLEFT", button, "TOPLEFT", -2, -2)
			hotkey:Show()
			SetOverrideBindingClick(button, true, key, button:GetName(), "LeftButton")
		end
	end
end

f:RegisterEvent("ACTIONBAR_PAGE_CHANGED")
f:RegisterEvent("ADDON_LOADED")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:RegisterEvent("UPDATE_BINDINGS")
f:RegisterEvent("PLAYER_LOGIN")
--f:RegisterEvent("PLAYER_LOSES_VEHICLE_DATA")
--f:RegisterEvent("PLAYER_GAINS_VEHICLE_DATA")

f:SetScript("OnEvent", MyFuncs.OnEvent)
f:SetScript("OnUpdate", function(self, elapsed)
	for i=1,12,1 do
		if not UnitAffectingCombat("player") then
			if MainMenuBar:IsShown() == 1 and _G["ExtraBarButton"..i]:IsShown() == nil then
				_G["ExtraBarButton"..i]:Show()
			elseif MainMenuBar:IsShown() == nil and _G["ExtraBarButton"..i]:IsShown() == 1 then
				_G["ExtraBarButton"..i]:Hide()
			end
		end
	end
	MyFuncs.UpdateBindings()
end)

local extrabar = CreateFrame("Frame", "MainMenuBarExtraBar", UIParent)
extrabar:SetSize(350, 80)
extrabar:SetPoint("BOTTOMLEFT", _G["MultiBarBottomRightButton1"], "TOPLEFT", 0, 4)

for id=13,24 do
	local b = CreateFrame("CheckButton", "ExtraBarButton"..(id-12), UIParent, "ActionBarButtonTemplate")
	b:SetSize(ActionButton1:GetWidth()*cfg.MainMenuBar.scale, ActionButton1:GetHeight()*cfg.MainMenuBar.scale)
	b:SetAttribute("action", id)
	b:SetID(id)
	b:SetPoint("BOTTOMLEFT", _G["MultiBarBottomRightButton"..(id-12)], "TOPLEFT", 0, 4)
	b:Show()
	b:SetParent(extrabar)
end
