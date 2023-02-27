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

    -- Set Armour Function
    armourSetting = 3, -- Set armour here: 0 = None, 1 = Revive ONLY, 2 = Respawn ONLY, 3 = Both Respawn & Revive (default)
    armourAmount = 100 -- Change the amount of armour to give the player when they respawn. If the above is false, this value is nullified

    -- Respawn Points
    spawnPoints = { -- Format: { x = 0.0, y = 0.0, z = 0.0, heading = 0.0 }
        { x = 0.0, y = 0.0, z = 0.0, heading = 0.0 },
        { x = 0.0, y = 0.0, z = 0.0, heading = 0.0 }
    },

    -- Discord Perms
    usePerms = true, -- Set to true if you want to use the discord perms, false if not
    bypassRoles = { -- These roles will be exempt from the revive & respawn timer
        { "roleID", "roleName" }, -- Add as many roles as you want here, using the format below
        { "roleID", "roleName" }
    },
}