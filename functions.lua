function _DrawMarker(markerType, x, y, z, rotY, scaleX, scaleY, scaleZ, r, g, b, a, bobUpAndDown, faceCamera, rotate)

    DrawMarker(markerType, x, y, z, 0.0, 0.0, 0.0, 0.0, rotY, 0.0, scaleX, scaleY, scaleZ, r, g, b, a, bobUpAndDown, faceCamera, 2, rotate, nil, nil, false)

end

function LoadAnimDict(animDict)

    RequestAnimDict(animDict)

	while not HasAnimDictLoaded(animDict) do
        
        Wait(1)

    end

end

function GetControlOfEntity(entity)

    repeat

        Wait(1)

        NetworkRequestControlOfEntity(entity)

    until NetworkHasControlOfEntity(entity)

end

function PlayFacialAnim(ped, animDict, animName)

    LoadAnimDict(animDict)

    ClearFacialIdleAnimOverride(ped)

    SetFacialClipsetOverride(ped, animDict)

    SetFacialIdleAnimOverride(ped, animName, animDict)

end

function LoadClipSet(clipSet)

    RequestClipSet(clipSet)

    while not HasClipSetLoaded(clipSet) do

        Wait(0)

    end

end

function PlayAnim(ped, animDict, animName, blendInSpeed, blendOutSpeed, duration, flag, playbackRate)

    LoadAnimDict(animDict)

    TaskPlayAnim(ped, animDict, animName, blendInSpeed, blendOutSpeed, duration, flag, playbackRate, false, false, false)

end

function StopAnim(ped, animDict, animName, animExitSpeed)

    StopAnimTask(ped, animDict, animName, animExitSpeed)

end

function LoadParticle(fxDict)

    RequestNamedPtfxAsset(fxDict)

    while not HasNamedPtfxAssetLoaded(fxDict) do

        Citizen.Wait(0)

    end

    UseParticleFxAssetNextCall(fxDict)

end

function LoadModel(model)

    while not HasModelLoaded(model) do

        RequestModel(model)

        Wait(1)

    end

end

function LoadRopes()

    RopeLoadTextures()

    SetRopesCreateNetworkWorldState(true)

    while not RopeAreTexturesLoaded() do

        Wait(0)

    end

end

function DrawSubtitle(text, x, y)

    SetTextFont(0)

    SetTextScale(0.35, 0.35)

    SetTextColour(255, 255, 255, 255)

    SetTextEdge(1, 0, 0, 0, 255)

    SetTextOutline()

    SetTextEntry("STRING")

    AddTextComponentString(text)

    DrawText(x, y)

end

function DrawText3D(x, y, z, text)

    local _, screenX, screenY = World3dToScreen2d(x, y, z)

    SetTextScale(0.35, 0.35)

    SetTextFont(4)

    SetTextProportional(true)

    SetTextColour(255, 255, 255, 215)

    SetTextEntry("STRING")

    SetTextCentre(true)

    AddTextComponentString(text)

    DrawText(screenX, screenY)

    local factor = (string.len(text)) / 370

    DrawRect(screenX, screenY + 0.0125, 0.015 + factor, 0.03, 0, 0, 0, 100)

end

function GetNearestVehicles(radius)

	local r = {}

	local px,py,pz = table.unpack(GetEntityCoords(PlayerPedId()))

	local vehs = {}

	local it,veh = FindFirstVehicle()

	if veh then

		table.insert(vehs,veh)

	end

	local ok

	repeat

		ok,veh = FindNextVehicle(it)

		if ok and veh then

			table.insert(vehs,veh)

		end

	until not ok

	EndFindVehicle(it)

	for _,veh in pairs(vehs) do

		local x,y,z = table.unpack(GetEntityCoords(veh))

		local distance = Vdist(x,y,z,px,py,pz)

		if distance <= radius then

			r[veh] = distance

		end

	end

	return r
end

function GetNearestVehicle(radius)

	local veh

	local vehs = GetNearestVehicles(radius)

	local min = radius+0.0001

	for _veh,dist in pairs(vehs) do

		if dist < min then

			min = dist

			veh = _veh

		end

	end

	return veh

end

function LoadTextureDict(textureDict)

    RequestStreamedTextureDict(textureDict, true)

    while not HasStreamedTextureDictLoaded(textureDict) do Wait(1) end

end