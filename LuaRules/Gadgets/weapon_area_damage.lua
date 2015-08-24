--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
if not gadgetHandler:IsSyncedCode() then
	return
end
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
function gadget:GetInfo()
	return {
		name = "Area Denial",
		desc = "Lets a weapon's damage persist in an area",
		author = "KDR_11k (David Becker), Google Frog",
		date = "2007-08-26",
		license = "Public domain",
		layer = 21,
		enabled = true
	}
end

local frameNum
local explosionList = {}
local DAMAGE_PERIOD, weaponInfo = include("LuaRules/Configs/area_damage_defs.lua")

--misc
local rowCount = 0 --remember the lenght of explosionList table
local emptyRow = {count=0} --remember empty position in explosionList table.
--

function gadget:UnitPreDamaged(unitID, unitDefID, unitTeam, damage, paralyzer, weaponDefID, attackerID, attackerDefID, attackerTeam)
	if weaponInfo[weaponDefID] and weaponInfo[weaponDefID].impulse then
		return 0
	end
	return damage
end


function gadget:Explosion(weaponID, px, py, pz, ownerID)
	if (weaponInfo[weaponID]) then
		local w = {
			radius = weaponInfo[weaponID].radius,
			damage = weaponInfo[weaponID].damage,
			impulse = weaponInfo[weaponID].impulse,
			expiry = frameNum + weaponInfo[weaponID].duration,
			rangeFall = weaponInfo[weaponID].rangeFall,
			timeLoss = weaponInfo[weaponID].timeLoss,
			id = weaponID,
			pos = {x = px, y = py, z = pz},
			owner=ownerID,
		}
		if emptyRow.count > 0 then
			local emptyPos = emptyRow[emptyRow.count]
			emptyRow.count = emptyRow.count-1
			if emptyPos then -- sometimes emptyPos is nil and this is worrying.
				emptyRow[emptyPos] = nil
				explosionList[emptyPos] = w --insert new data at empty position in explosionList table
			end
		else
			rowCount = rowCount + 1
			explosionList[rowCount] = w --insert new data at a new position at end of explosionList table
		end
	end
	return false
end

local totalDamage = 0

function gadget:GameFrame(f)
	frameNum=f
	if (f%DAMAGE_PERIOD == 0) then
		for i,w in pairs(explosionList) do
			local pos = w.pos
			local ulist = Spring.GetUnitsInSphere(pos.x, pos.y, pos.z, w.radius)
			if (ulist) then
				for j=1, #ulist do
					local u = ulist[j]
					local ux, uy, uz = Spring.GetUnitPosition(u)
					local damage = w.damage
					if w.rangeFall ~= 0 then
						damage = damage - damage*w.rangeFall*math.sqrt((ux-pos.x)^2 + (uy-pos.y)^2 + (uz-pos.z)^2)/w.radius
					end
					if w.impulse then
						GG.AddGadgetImpulse(u, pos.x - ux, pos.y - uy, pos.z - uz, damage, false, true, false, {0.22,0.7,1})
						GG.SetUnitFallDamageImmunity(u, f + 10)
						GG.DoAirDrag(u, damage)
					else
						Spring.AddUnitDamage(u, damage, 0, w.owner, w.id, 0, 0, 0)
					end
				end
			end
			w.damage = w.damage - w.timeLoss
			if f >= w.expiry then
				explosionList[i] = nil
				emptyRow.count = emptyRow.count + 1
				emptyRow[emptyRow.count] = i --remember where is all empty position in explosionList table
			end
		end
	end
end

function gadget:Initialize()
	for w,_ in pairs(weaponInfo) do
		Script.SetWatchWeapon(w, true)
	end
end