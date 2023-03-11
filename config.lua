--------------------------------
--- FaxRevive, Made by FAXES ---
--------------------------------

config = {
    -- Revive/Respawn Settings
    scriptSetting = 3, -- 1 = Revive ONLY, 2 = Respawn ONLY, 3 = Both Respawn & Revive (default)    

    -- Revive Timer Values (in seconds)
    reviveTimer = 10, -- Change the amount of time to wait before allowing revive
    respawnTimer = 5, -- Change the amount of time to wait before allowing revive

    -- Info Text Colors
    reviveColor = "~g~", -- Color used for revive button
    respawnColor = "~b~", -- Color used for respawn button
    chatColor = "~w~", -- The chat color overall

    -- Set Armour Function
    armourSetting = 3, -- Set armour here: 0 = None, 1 = Revive ONLY, 2 = Respawn ONLY, 3 = Both Respawn & Revive (default)
    armourAmount = 100, -- Change the amount of armour to give the player when they respawn. If the above is false, this value is nullified

    -- Respawn Points
    spawnPoints = { -- Format: { x = 0.0, y = 0.0, z = 0.0, heading = 0.0 }
        { x = -2487.31, y = 3596.41, z = 14.61, heading = 340.65 },
        { x = 172.81, y = 6611.71, z = 31.87, heading = 309.06 },
    },

    -- Discord Perms (Requires Badger_Discord_API resource)
    usePerms = false, -- Set to true if you want to use the discord perms, false if not
    bypassRoles = { -- These roles will be exempt from the revive & respawn timer
        { "roleID", "roleName" }, -- Add as many roles as you want here, using the format below
        { "roleID", "roleName" }
    },

    -- Debug
    debug = true -- Set to true if you want to see debug messages in the console, false if not
}