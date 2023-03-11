--------------------------------
--- FaxRevive, Made by FAXES ---
--------------------------------

-- WE RECOMMEND NOT EDITING THIS FILE UNLESS YOU KNOW WHAT YOU'RE DOING.
-- STAY IN THE CONFIG.LUA FILE! :)

--- Code ---
if config.usePerms then 
    RegisterServerEvent("FaxRevive:CheckPermission")
    AddEventHandler("FaxRevive:CheckPermission", function()
        local src = source
        for k, v in ipairs(GetPlayerIdentifiers(src)) do
            if string.sub(v, 1, string.len("discord:")) == "discord:" then
                identifierDiscord = v
            end
        end

        if identifierDiscord then
            local count = 0
            local roleIDs = exports.Badger_Discord_API:GetDiscordRoles(src)
            if not (roleIDs == false) then
                for i = 1, #roleIDs do
                    if exports.Badger_Discord_API:CheckEqual(config.bypassRoles[i][1], roleIDs[j]) and i ~= 1 then
                        TriggerClientEvent("FaxRevive:CheckPermission:Return", src, true)
                        count = count + 1
                        break
                    end
                end

                if count == 0 then
                    TriggerClientEvent("FaxRevive:CheckPermission:Return", src, false)
                end
            else
                TriggerClientEvent("FaxRevive:CheckPermission:Return", src, false)
            end
        end
    end)
end