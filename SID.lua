addEventHandler ( "onPlayerJoin", root, function()
    local id = math.random(1, 500)
    for i, v in pairs(getElementsByType("player")) do
        local pID = getElementData(v, "id")
        while id == pID do
            id = math.random(1, 500)
        end
    end
    setElementData(source, "id", id)
    setElementData(source, "faction_id", 0)
    setElementData(source, "faction_leader", false)

    triggerClientEvent(source, "drawLocalID", source)
    triggerClientEvent(source, "drawIDAboveHead", source)
end)