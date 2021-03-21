PZShared.netRegisterAndHandle("pz_basicCommands:car", function(car)
    PZClient.requestModel(car)
    PZClient.spawnVehicleAndWarpPed(car, -1, GetEntityCoords(PlayerPedId()), GetEntityHeading(PlayerPedId()))
end)

PZShared.netRegisterAndHandle("pz_basicCommands:revive", function()
    NetworkResurrectLocalPlayer(GetEntityCoords(PlayerPedId()), 90.0, 0, 0)
end)