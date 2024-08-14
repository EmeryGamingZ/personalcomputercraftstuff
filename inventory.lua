local manager = peripheral.find("inventoryManager")
local modem = peripheral.find("modem")

term.clear()
term.setCursorPos(1, 1)

if (not manager) then print("No Manager") end
print("Doing ammo shit")


local ammoSlot = 28
local waterSlot = 5
local carrotSlot = 6

local function ItemReservoir()
	while true do
		
		if (manager.addItemToPlayer("up", {name="tacz:ammo", toSlot=ammoSlot, count=60})) then end
		if (manager.addItemToPlayer("back", {name="minecraft:potion", toSlot=waterSlot, count=1})) then end
        if (manager.addItemToPlayer("bottom", {name="minecraft:carrot", toSlot=carrotSlot, count=64})) then end
		
		local invTable = manager.getItems()
		for slot, item in pairs(invTable) do
			local slot = item.slot
			--print(item.name, slot)
			if (item.displayName == "[Water Bottle]") then
				if (slot ~= waterSlot) then
					--print("Womp", item.DisplayName, slot)
					local Ftable = {fromSlot=slot, count=64}
					local nuffmber = manager.removeItemFromPlayer("back", Ftable)
				end
            elseif (item.name == "tacz:ammo") then
				if (slot ~= ammoSlot) then
					--print("Womp", item.DisplayName, slot)
					local Ftable = {fromSlot=slot, count=64}
					local nuffmber = manager.removeItemFromPlayer("up", Ftable)
				end
            elseif (item.name == "minecraft:carrot") then
				if (slot ~= carrotSlot) then
					--print("Womp", item.DisplayName, slot)
					local Ftable = {fromSlot=slot, count=64}
					local nuffmber = manager.removeItemFromPlayer("down", Ftable)
				end
        	elseif (item.name == "minecraft:glass_bottle") then
				if (true) then
					--print("Womp", item.DisplayName, slot)
					local Ftable = {fromSlot=slot, count=64}
					local nuffmber = manager.removeItemFromPlayer("back", Ftable)
				end
			end
		end
	end
end


local dothething = false

local function ModemThing()
    port = 12384
	modem.open(port)
	while true do
		local _, _, senderID, _, message = os.pullEvent("modem_message")
		if (message == "do the thing") then
			dothething = (not dothething)
            
		end
	end
end

local function ModemThingItemMover()
    while true do
        sleep(1)
        while (dothething) do
            local Ftable = {fromSlot=17, count=64}
			local nuffmber = manager.removeItemFromPlayer("right", Ftable)
        end
    end
 end

parallel.waitForAll(
	ItemReservoir,
	ModemThing,
    ModemThingItemMover

)


