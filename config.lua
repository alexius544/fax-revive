--------------------------------
--- FaxRevive, Made by FAXES ---
--------------------------------

--- Config ---

config = {
    -- Revive/Respawn Settings
    scriptSetting = 3, -- 1 = Revive ONLY, 2 = Respawn ONLY, 3 = Both Respawn & Revive (default)

    -- Revive Timer Values (in seconds)
    reviveTimer = 10, -- Change the amount of time to wait before allowing revive
    respawnTimer = 5, -- Change the amount of time to wait before allowing revive

    -- Info Text Colors
    reviveColor = "~y~", -- Color used for revive button
    respawnColor = "~r~", -- Color used for respawn button
    chatColor = "~b~", -- The chat color overall

    -- Discord Perms
    usePerms = true, -- Set to true if you want to use the discord perms, false if not
    bypassRoles = { -- These roles will be exempt from the revive & respawn timer
        { "roleID", "roleName" }, -- Add as many roles as you want here, using the format below
        { "roleID", "roleName" }
    },

    -- Set Armour Function
    respawnSetting = 3, -- Set armour here: 1 = Revive ONLY, 2 = Respawn ONLY, 3 = Both Respawn & Revive (default)
    setArmour = true, -- Set to true if you want to set the player's armour to 100 when they respawn, false if not
    armourAmount = 100 -- Change the amount of armour to give the player when they respawn. If the above is false, this value is nullified
}