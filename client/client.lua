lib.locale()
local validWeapons = Config.validWeapons

function KillPlayer()
	CreateThread(function()
		local PlayerPed = PlayerPedId()

		local canSuicideWithGun = false
		local foundWeapon = nil
		local method = nil

		if Config.CanUseGun then
			-- for i = 1, #validWeapons do
			for _, weaponHash in pairs(validWeapons) do -- DOES IT WORK?
				if HasPedGotWeapon(PlayerPed, weaponHash, false) then
					local ammo = GetAmmoInPedWeapon(PlayerPed, weaponHash)
					if ammo > 0 then
						canSuicideWithGun = true
						foundWeapon = weaponHash
						break
					else
						lib.notify({
							id = 'notify_no_ammo',
							title = locale('no_ammo_title'),
							description = locale('no_ammo_description'),
							position = 'top',
							style = {
								backgroundColor = '#141517',
								color = '#909296'
							},
							icon = 'ban',
							iconColor = '#C53030'
						})
					end
				else -- HERE
					canSuicideWithGun = false
					break
				end -- END
			end


			local dict = 'mp_suicide'
			local timeout = 100

			lib.requestAnimDict(dict, timeout)
			if canSuicideWithGun then
				method = "pistol"
				SetCurrentPedWeapon(PlayerPed, foundWeapon, true)
				TaskPlayAnim(PlayerPed, dict, method, 8.0, 1.0, -1, 2, 0, false, false, false)
				Wait(750)
				TriggerServerEvent('enty-suicide:ShootAtCoord', PlayerPed)
				--SetPedShootsAtCoord(PlayerPed, 0.0, 0.0, 0.0, true)
				Wait(500)
			else
				if Config.CanUsePill then
					method = "pill"
					lib.requestAnimDict(dict, timeout)
					TaskPlayAnim(PlayerPed, dict, method, 8.0, 1.0, -1, 2, 0, false, false, false)
					Wait(5200)
				end
			end
			-- if HasEntityAnimFinished(PlayerPed, dict, method, 3) then
			--SetEntityHealth(PlayerPed, 0)
			--Death(method)
			--end
		else
			canSuicideWithGun = false
		end
	end)
end

function ScreenFade()
	DoScreenFadeOut(2000)
	Wait(5000)
	DoScreenFadeIn(2000)
	Wait(200)
end

function RemoveLeftovers(PlayerCopy)
	CreateThread(function()
		local Ped = PlayerCopy
		IsEntityAPed(ped)
		DeletePed(Ped)
		print("Removed")
	end)
end

function Death(method)
	CreateThread(function()
		local PlayerPed = PlayerPedId()
		-- local PlayerCopy = ClonePed(PlayerPedId(), true, false, true)
		-- local pos = GetEntityCoords(PlayerPed, false)
		-- --ScreenFade()
		-- print("screenfade")

		-- IsPedRagdoll(PlayerCopy)
		-- SetEntityHealth(PlayerCopy, 0)
		-- if method == "pistol" then
		-- 	ApplyPedDamagePack(PlayerCopy, "Fall", 100, 100)
		-- end
		-- SetEntityCoords(PlayerCopy, pos.x, pos.y, pos.z - 1.0)
		-- SetEntityVisible(PlayerPed, false)
		-- SetEntityCollision(PlayerPed, false, false)
		-- FreezeEntityPosition(PlayerPed, true)
		-- Wait(5000)
		-- TestMode()
		-- Wait(5000)
		-- DeletePed(PlayerCopy)
		-- --RemoveLeftovers()
	end)
end

function TestMode()
	CreateThread(function()
		local PlayerPed = PlayerPedId()
		SetEntityVisible(PlayerPed, true, false)
		SetEntityCollision(PlayerPed, true, true)
		FreezeEntityPosition(PlayerPed, false)
	end)
end

RegisterCommand('s', function(source, args)
	print("s")
end, false)

-- RegisterNetEvent('suicide')
-- AddEventHandler('suicide', function(source)

RegisterCommand('suicide', function(source, args)
	local PlayerPed = PlayerPedId()
	local Vehicle = GetVehiclePedIsIn(PlayerPed, false)
	if not IsEntityDead(PlayerPed) then
		if not IsPedInVehicle(PlayerPed, Vehicle, true) then
			local alert = lib.alertDialog({
				header = locale('header_warning'),
				content = locale('content_warning'),
				centered = true,
				cancel = true
			})
			if alert:find("confirm") then
				-- do something if you clicked confirmed
				KillPlayer()
			else
				return lib.closeAlertDialog()
				--cancel
			end
		end
	else
		return {
			lib.notify({
				id = 'notify_already_dead',
				title = locale('already_dead_title'),
				description = locale('already_dead_description'),
				position = 'top',
				style = {
					backgroundColor = '#141517',
					color = '#909296'
				},
				icon = 'face-eyes-xmarks',
				iconColor = '#C53030'
			})
		}
	end
end, false)
