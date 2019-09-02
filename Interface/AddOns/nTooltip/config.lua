
local _, nTooltip = ...

nTooltip.Config = {
    fontSize = 13,
    fontOutline = false,

    position = {
		--"BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -80, 262
		"BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -95, 293
    },

    showOnMouseover = false,
    hideInCombat = false,                       -- Hide unit frame tooltips during combat

    reactionBorderColor = false,
    itemqualityBorderColor = true,

    abbrevRealmNames = false,
    showPlayerTitles = false,
    showUnitRole = false,
    showPVPIcons = false,                       -- Show pvp icons instead of just a prefix
    showMouseoverTarget = false,
    showSpecializationIcon = false,

    healthbar = {
        showHealthValue = true,

        healthFormat = "$perc",           -- Possible: $cur, $max, $deficit, $perc, $smartperc, $smartcolorperc, $colorperc
        healthFullFormat = "$perc",              -- if the tooltip unit has 100% hp

        fontSize = 14,
        font = STANDARD_TEXT_FONT,
        showOutline = true,
        textPos = "CENTER",                     -- Possible "TOP" "BOTTOM" "CENTER"

        reactionColoring = false,               -- Overrides customColor
        customColor = {
            apply = false,
            r = 0,
            g = 1,
            b = 1
        }
    },
}
