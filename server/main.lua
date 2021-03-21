-- Restricted commands
PZServer.registerRestrictedCommand("car", {"cmd.car"}, function(source, args)
    local car = args[1] or "panto"
    PZServer.toClient("pz_basicCommands:car", source, car)
end)

PZServer.registerRestrictedCommand("revive", {"cmd.revive"}, function(source, args)
    local target = tonumber(args[1])
    if target then
        if not PZPlayersManager.getPlayer(target) then
            PZShared.warn(PZColor.red..PZShared.translate("player_offline"))
            return
        end
        PZServer.toClient("pz_basicCommands:revive", target)
        PZShared.trace(PZShared.translate("player_revived"):format(GetPlayerName(target)))
    else
        PZServer.toClient("pz_basicCommands:revive", source)
        PZShared.trace(PZShared.translate("revived"))
    end
end)

-- Console commands
PZServer.registerConsoleCommand("setGroup", function(source, args)
    if #args < 1 or #args > 2 then
        PZShared.warn(PZShared.getUsage("setGroup", {"playerID", "groupID"}))
        return
    end

    local target = tonumber(args[1])
    local targetRank = tonumber(args[2])

    if not PZPlayersManager.getPlayer(target) then
        PZShared.warn(PZColor.red..PZShared.translate("player_offline"))
        return
    end

    if not PZRanksManager.getRank(targetRank) then
        PZShared.warn(PZColor.red..PZShared.translate("rank_missing"))
        return
    end

    local success = PZRanksManager.setRank(target, targetRank)
    if success then
        ---@type PZRank
        local rank = PZRanksManager.getRank(targetRank)
        PZShared.trace(PZShared.translate("rank_updated"):format(GetPlayerName(target), rank.display))
    end
end)