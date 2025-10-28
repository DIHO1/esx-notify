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
-- Warstwa Kompatybilności v3 by Jules (Tłumacz Ostateczny + Filtr)
-- =================================================================

-- Mechanizm "Anty-Duplikat"
local lastNotification = ""
local lastNotificationTime = 0

local function showCompatibilityNotification(...)
    -- Sprawdzamy, czy to duplikat
    local currentTime = GetGameTimer()
    if (currentTime - lastNotificationTime < 100) and table.concat(args, " ") == lastNotification then
        return -- Ignoruj, jeśli to duplikat
    end
    lastNotification = table.concat(args, " ")
    lastNotificationTime = currentTime

    local args = table.pack(...)

    -- Domyślne wartości
    local message = "Brak treści."
    local title = "Powiadomienie"
    local icon = 'fas fa-info-circle text-info'
    local time = 7000

    local typeToIconMap = {
        ['success'] = 'far fa-check-circle text-success', ['~g~'] = 'far fa-check-circle text-success',
        ['error'] = 'fas fa-exclamation-circle text-danger', ['~r~'] = 'fas fa-exclamation-circle text-danger',
        ['info'] = 'fas fa-info-circle text-info', ['~b~'] = 'fas fa-info-circle text-info',
        ['warning'] = 'fas fa-exclamation-triangle text-warning', ['~y~'] = 'fas fa-exclamation-triangle text-warning'
    }

    -- Inteligentne parsowanie argumentów ("Tłumacz v3")
    if args.n == 1 then
        -- 1. Tylko wiadomość: esx:showNotification("Wiadomość")
        message = tostring(args[1])
    elseif args.n == 2 then
        local arg1, arg2 = tostring(args[1]), tostring(args[2])
        if typeToIconMap[arg2] then
            -- 2. Wiadomość i typ: esx:showNotification("Wiadomość", "error")
            message = arg1
            icon = typeToIconMap[arg2]
        elseif tonumber(arg2) then
            -- 3. Wiadomość i CZAS TRWANIA: esx:showNotification("Wiadomość", 5000)
            message = arg1
            time = tonumber(arg2)
        else
            -- 4. Tytuł i wiadomość: esx:showNotification("Tytuł", "Wiadomość")
            title = arg1
            message = arg2
        end
    elseif args.n >= 3 then
        -- 5. Tytuł, wiadomość i typ/czas: esx:showNotification("Tytuł", "Wiadomość", "success")
        title = tostring(args[1])
        message = tostring(args[2])
        if typeToIconMap[tostring(args[3])] then
            icon = typeToIconMap[tostring(args[3])]
        end
    end

    -- Filtr "anty-śmieciowy": Ignoruje powiadomienia, gdzie tytuł i treść to tylko liczby
    if tonumber(title) and tonumber(message) then
        return
    end

    -- Wywołujemy nową, główną funkcję `notification` z poprawnie przetłumaczonymi danymi
    notification(icon, "System", title, message, time, 'default')
end

-- Przechwytujemy wszystkie stare metody wywołania
RegisterNetEvent('esx:showNotification', showCompatibilityNotification)
exports('Notify', showCompatibilityNotification)
