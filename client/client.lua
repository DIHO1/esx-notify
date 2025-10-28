-- =================================================================
-- Oryginalny kod dostarczony przez użytkownika (bez zmian)
-- =================================================================

function notification(icon, appname, title, message, time, sound)
	if sound == nil then
		sound = 'default'
	end
	SendNUIMessage({
		action = 'open',
		sound = sound,
		icon = icon,
		title = title,
		message = message,
		time = time,
		appname = appname
	})
end

function specjalcwel(title, text, time)
	if sound == nil then
		sound = 'default'
	end
	SendNUIMessage({
		action = 'open',
		sound = sound,
		icon = 'fas fa-exclamation-circle text-danger',
		title = title,
		message = text,
		time = time,
		appname = 'Marolli-Scripts'
	})
end

RegisterNetEvent('notification:show')
AddEventHandler('notification:show', function(icon, appname, title, message, time, sound)
	notification(icon, appname, title, message, time, sound)
end)

exports('Notification', notification)
exports('Specjal', specjalcwel)


-- =================================================================
-- Warstwa Kompatybilności v4 by Jules (Tłumacz Ostateczny)
-- =================================================================

-- Mechanizm "Anty-Duplikat"
local lastNotification = ""
local lastNotificationTime = 0

local function showCompatibilityNotification(...)
    local args = table.pack(...)

    -- Anty-Duplikat
    local currentTime = GetGameTimer()
    if (currentTime - lastNotificationTime < 100) and table.concat(args, " ") == lastNotification then
        return
    end
    lastNotification = table.concat(args, " ")
    lastNotificationTime = currentTime

    -- Domyślne wartości
    local message, title, icon, time = nil, "Powiadomienie", 'fas fa-info-circle text-info', 7000
    local typeToIconMap = {
        ['success'] = 'far fa-check-circle text-success', ['~g~'] = 'far fa-check-circle text-success',
        ['error'] = 'fas fa-exclamation-circle text-danger', ['~r~'] = 'fas fa-exclamation-circle text-danger',
        ['info'] = 'fas fa-info-circle text-info', ['~b~'] = 'fas fa-info-circle text-info',
        ['warning'] = 'fas fa-exclamation-triangle text-warning', ['~y~'] = 'fas fa-exclamation-triangle text-warning'
    }

    -- "Tłumacz v4" - Logika ostateczna
    local tempArgs = {}
    for i = 1, args.n do
        table.insert(tempArgs, tostring(args[i]))
    end

    -- 1. Znajdź i ustaw typ (ikonę)
    for i, arg in ipairs(tempArgs) do
        if typeToIconMap[arg] then
            icon = typeToIconMap[arg]
            table.remove(tempArgs, i)
            break
        end
    end

    -- 2. Znajdź i ustaw czas
    for i, arg in ipairs(tempArgs) do
        if tonumber(arg) and tonumber(arg) > 500 then -- Uznajemy, że liczba > 500 to czas
            time = tonumber(arg)
            table.remove(tempArgs, i)
            break
        end
    end

    -- 3. To, co zostało, to tytuł i/lub treść
    if #tempArgs == 1 then
        message = tempArgs[1]
    elseif #tempArgs >= 2 then
        title = tempArgs[1]
        message = tempArgs[2]
    end

    -- Jeśli po wszystkim wiadomość jest pusta, ignoruj
    if message == nil or message == '' then return end

    notification(icon, "System", title, message, time, 'default')
end

-- Przechwytujemy wszystkie stare metody wywołania
RegisterNetEvent('esx:showNotification', showCompatibilityNotification)
exports('Notify', showCompatibilityNotification)
