--------------------------------
--- FaxRevive, Made by FAXES ---
--------------------------------

timerCount1 = config.reviveTimer
timerCount2 = config.respawnTimer
isDead = false
cHavePerms = false
spawnPoints = config.spawnPoints

-- Create notification text.
function ShowInfoMsg(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentSubstringPlayerName(text)
	DrawNotification(true, true)
end

-- Checking for permissions.
if config.usePerms then
	AddEventHandler('playerSpawned', function()
		local src = source
		TriggerServerEvent("FaxRevive:CheckPermission", src)
	end)

	RegisterNetEvent("FaxRevive:CheckPermission:Return")
	AddEventHandler("FaxRevive:CheckPermission:Return", function(havePerms)
		cHavePerms = havePerms
	end)
end

-- Turn off automatic respawn here instead of updating FiveM file.
AddEventHandler('onClientMapStart', function()
	if config.debug then
		Citizen.Trace("[DEBUG] FaxRevive: Disabling the autospawn.")
	end
	exports.spawnmanager:spawnPlayer() -- Ensure player spawns into server.
	Citizen.Wait(2500) -- Wait before disabling autospawn to ensure it loads properly.
	exports.spawnmanager:setAutoSpawn(false) -- Disable autospawn.
	if config.debug then
		Citizen.Trace("[DEBUG] FaxRevive: Autospawn has now been disabled.")
	end
end)

-- Checks for settings (1 = revive only OR 3 = both) and sets up revive/respawn functions.
if config.scriptSetting == 1 or config.scriptSetting == 3 then
	function revivePed(ped)
		isDead = false
		timerCount1 = config.reviveTimer
		timerCount2 = config.respawnTimer
		local playerPos = GetEntityCoords(ped, true)
		NetworkResurrectLocalPlayer(playerPos, true, true, false)
		SetPlayerInvincible(ped, false)
		ClearPedBloodDamage(ped)
		if config.showNoti then
			ShowInfoMsg('~g~You have been revived successfully!')
		end
		if config.armourSetting == 1 or config.armourSetting == 3 then
			SetPedArmour(ped, config.armourAmount)
			if config.debug then
				Citizen.Trace("[DEBUG] FaxRevive: Player armour set to " .. config.armourAmount .. ".")
			end
		end
		if config.debug then
			if cHavePerms then
				Citizen.Trace("[DEBUG] FaxRevive: Player revived. (Has Staff Permissions)")
			else
				Citizen.Trace("[DEBUG] FaxRevive: Player revived.")
			end
		end
	end
end

-- Checks for settings (2 = respawn only OR 3 = both) and sets up revive/respawn functions.
if config.scriptSetting == 2 or config.scriptSetting == 3 then
	function respawnPed(ped, coords)
		isDead = false
		timerCount1 = config.reviveTimer
		timerCount2 = config.respawnTimer
		respawnLocName = coords.name
		SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
		NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, coords.heading, true, false) 
		SetPlayerInvincible(ped, false) 
		TriggerEvent('playerSpawned', coords.x, coords.y, coords.z, coords.heading)
		ClearPedBloodDamage(ped)
		if config.showNoti then
			ShowInfoMsg('~g~You have been respawned successfully!')
		end
		if config.armourSetting == 2 or config.armourSetting == 3 then
			SetPedArmour(ped, config.armourAmount)
			if config.debug then
				Citizen.Trace("[DEBUG] FaxRevive: Player armour set to " .. config.armourAmount .. ".")
			end
		end
		if config.debug then
			if cHavePerms then
				Citizen.Trace("[DEBUG] FaxRevive: Player respawned. (Has Staff Permissions)")
			else
				Citizen.Trace("[DEBUG] FaxRevive: Player respawned.")
			end
		end
	end
end

Citizen.CreateThread(function()
    while true do
    	Citizen.Wait(0)
		ped = GetPlayerPed(-1)
        if IsEntityDead(ped) then
			isDead = true
            SetPlayerInvincible(ped, true)
            SetEntityHealth(ped, 1)
			ShowInfoMsg(config.chatColor .. 'You are dead.\nUse ' .. config.reviveColor .. 'E ' .. config.chatColor ..'to revive or ' .. config.respawnColor .. 'R ' .. config.chatColor .. 'to respawn.')
            if IsControlJustReleased(0, 38) and GetLastInputMethod(0) then
                if timerCount1 == 0 or cHavePerms then
                    revivePed(ped)
				else
					TriggerEvent('chat:addMessage', { args = {'^*[^1FaxRevive^0]^r Please wait ^2' .. timerCount1 .. '^0 seconds before reviving!'}})
                end	
            elseif IsControlJustReleased(0, 45) and GetLastInputMethod(0) then
                if timerCount2 == 0 or cHavePerms then
					local coords = spawnPoints[math.random(1, #spawnPoints)]
					respawnPed(ped, coords)
				else
					TriggerEvent('chat:addMessage', { args = {'^*[^1FaxRevive^0]^r Please wait ^2' .. timerCount2 .. '^0 seconds before respawning!'}})
				end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        if isDead then
			if timerCount1 ~= 0 then
				timerCount1 = timerCount1 - 1
			end

			if timerCount2 ~= 0 then
				timerCount2 = timerCount2 - 1
			end
        end
        Citizen.Wait(1000)          
    end
end)