--------------------------------
--- FaxRevive, Made by FAXES ---
--------------------------------

--- Code ---
timerCount1 = config.reviveTimer
timerCount2 = config.respawnTimer
isDead = false
cHavePerms = false

-- for _, Station in pairs(Config.LEOStations) do

-- Create spawn points here!
local spawnPoints = {}
function createSpawnPoint(x, y, z, heading)
	local newObject = {
		x = x,
		y = y,
		z = z,
		heading = heading
	}
	
	table.insert(spawnPoints, newObject)
end
-- Add spawn points here... format: createSpawnPoint(x, y, z, heading)
createSpawnPoint(1828.44, 3692.32, 34.22, 37.12) -- Back of Sandy Shores Hospital

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
	Citizen.Trace("FaxRevive: Disabling the autospawn.")
	exports.spawnmanager:spawnPlayer() -- Ensure player spawns into server.
	Citizen.Wait(2500)
	exports.spawnmanager:setAutoSpawn(false)
	Citizen.Trace("FaxRevive: Autospawn is disabled.")
end)

-- Checks for settings (1 = revive only OR 3 = both) and sets up revive/respawn functions.
if config.scriptSetting == 1 or config.scriptSetting == 3 then
	function revivePed(ped)
		isDead = false
		timerCount1 = reviveTimer
		timerCount2 = respawnTimer
		local playerPos = GetEntityCoords(ped, true)
		NetworkResurrectLocalPlayer(playerPos, true, true, false)
		SetPlayerInvincible(ped, false)
		ClearPedBloodDamage(ped)
		if config.armourSetting == 1 or config.armourSetting == 3 then
			SetPedArmour(ped, config.armourAmount)
		end
	end
end

-- Checks for settings (2 = respawn only OR 3 = both) and sets up revive/respawn functions.
if config.scriptSetting == 2 or config.scriptSetting == 3 then
	function respawnPed(ped, coords)
		isDead = false
		timerCount1 = reviveTimer
		timerCount2 = respawnTimer
		SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
		NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, coords.heading, true, false) 
		SetPlayerInvincible(ped, false) 
		TriggerEvent('playerSpawned', coords.x, coords.y, coords.z, coords.heading)
		ClearPedBloodDamage(ped)
		if config.armourSetting == 2 or config.armourSetting == 3 then
			SetPedArmour(ped, config.armourAmount)
		end
	end
end

function ShowInfoRevive(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentSubstringPlayerName(text)
	DrawNotification(true, true)
end

Citizen.CreateThread(function()
    while true do
    	Citizen.Wait(0)
		ped = GetPlayerPed(-1)
        if IsEntityDead(ped) then
			isDead = true
            SetPlayerInvincible(ped, true)
            SetEntityHealth(ped, 1)
			ShowInfoRevive(chatColor .. 'You are dead.\nUse ' .. reviveColor .. 'E ' .. chatColor ..'to revive or ' .. respawnColor .. 'R ' .. chatColor .. 'to respawn.')
            if IsControlJustReleased(0, 38) and GetLastInputMethod(0) then
                if timerCount1 == 0 or cHavePerms then
                    revivePed(ped)
				else
					TriggerEvent('chat:addMessage', {args = {'^1^*Wait ' .. timerCount1 .. ' more seconds before reviving'}})
                end	
            elseif IsControlJustReleased(0, 45) and GetLastInputMethod(0) then
                if timerCount2 == 0 or cHavePerms then
					local coords = spawnPoints[math.random(1,#spawnPoints)]
					respawnPed(ped, coords)
				else
					TriggerEvent('chat:addMessage', {args = {'^1^*Wait ' .. timerCount2 .. ' more seconds before respawning'}})
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
