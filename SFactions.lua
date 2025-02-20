function getPlayerFromID(pid)
    local player = nil
    for i, v in pairs(getElementsByType("player")) do
        local id = getElementData(v, "id")
        if pid == id then player = v end
    end
    return player
end

function DeclinePlayer(target)
    local player = client or source
    
    setElementData(target, "faction_id", 0)
    if getElementData(target, "faction_leader") == true then 
        setElementData(target, "faction_leader", false)
    end
end
addEvent("onLeaderDeclinePlayer", true)
addEventHandler("onLeaderDeclinePlayer", root, DeclinePlayer)

function AcceptPlayer(target)
    local player = client or source

    local faction_id = tonumber(getElementData(player, "faction_id"))

    setElementData(target, "faction_id", faction_id)

    -- if getElementData(target, "faction_leader") == true then
    --     setElementData(target, "faction_leader", false) -- Для тестов. Если приглашаемый игрок - лидер, то снимаем его с поста лидера + раскомментить 109 строку в CFactions.lua 
    -- end
end
addEvent("onLeaderAcceptPlayer", true)
addEventHandler("onLeaderAcceptPlayer", root, AcceptPlayer)

addCommandHandler("set_player_faction_leader", function(player, command, pid, faction)
    local WRONG_SYNTAX = "/set_player_faction_leader <player_id> <faction_id>"

    if not tonumber(pid) or tonumber(faction) < 0 then return outputChatBox(WRONG_SYNTAX, player, 255, 0, 0) end

    local target = getPlayerFromID(tonumber(pid))

    if not target then return outputChatBox("Игрок не существует", player, 255, 0, 0) end

    if not tonumber(faction) or tonumber(faction) == 0 then
        setElementData(target, "faction_id", 0)
        setElementData(target, "faction_leader", false)
        return 
    end
    setElementData(target, "faction_id", faction)
    setElementData(target, "faction_leader", true)
end)

addCommandHandler("set_player_faction", function(player, command, pid, faction)
    local WRONG_SYNTAX = "/set_player_faction <player_id> <faction_id>"

    if not tonumber(pid) or tonumber(faction) < 0 then return outputChatBox(WRONG_SYNTAX, player, 255, 0, 0) end

    local target = getPlayerFromID(tonumber(pid))

    if not target then return outputChatBox("Игрок не в сети", player, 255, 0, 0) end

    if not tonumber(faction) or tonumber(faction) == 0 then
        setElementData(target, "faction_id", 0)
        if getElementData(target, "faction_leader") == true then
            setElementData(target, "faction_leader", false)
        end
        return 
    end
    setElementData(target, "faction_id", faction)
end)

addCommandHandler("f", function(player, command, ...)
    if tonumber(getElementData(player, "faction_id")) <= 0 then return outputChatBox("Недостаточно прав", player, 255, 0, 0) end
    local WRONG_SYNTAX = "/f <text>"

    local message = table.concat( { ... }, ' ' )
    if utf8.len( message ) <= 0 then return outputChatBox(WRONG_SYNTAX, player, 255, 0, 0) end
    for i, v in pairs(getElementsByType("player")) do
        local fid = tonumber(getElementData(v, "faction_id"))

        if fid ~= tonumber(getElementData(player, "faction_id")) then return end
        outputChatBox( getPlayerName(player)..":"..message, v, 0, 0, 255 )
    end
end)