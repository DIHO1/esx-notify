-- =================================================================
-- Oryginalny kod dostarczony przez użytkownika
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

-- Ta funkcja wydaje się być specyficznym wariantem, zostawiam ją,
-- ponieważ może być używana przez inne Twoje skrypty.
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

-- Eksport nowej funkcji, aby inne skrypty mogły z niej korzystać
exports('Notification', notification)
exports('Specjal', specjalcwel)


-- =================================================================
-- Warstwa Kompatybilności by Jules (Tłumacz Starego na Nowe)
-- =================================================================

local function showCompatibilityNotification(...)
    local args = table.pack(...)
    local message = "Brak treści."
    local title = "Powiadomienie"
    -- Domyślna ikona, jeśli typ nie zostanie rozpoznany
    local icon = 'fas fa-info-circle text-info'
    local time = 7000 -- Domyślny czas wyświetlania dla starych powiadomień

    -- Mapa tłumacząca stare typy ESX na ikony Font Awesome i kolory Bootstrap
    local typeToIconMap = {
        ['success'] = 'far fa-check-circle text-success',
        ['error'] = 'fas fa-exclamation-circle text-danger',
        ['info'] = 'fas fa-info-circle text-info',
        ['warning'] = 'fas fa-exclamation-triangle text-warning',
        -- Dodatkowe mapowanie dla bardzo starych skryptów
        ['~g~'] = 'far fa-check-circle text-success',
        ['~r~'] = 'fas fa-exclamation-circle text-danger',
        ['~b~'] = 'fas fa-info-circle text-info',
        ['~y~'] = 'fas fa-exclamation-triangle text-warning'
    }

    if args.n == 1 then
        -- Przypadek 1: esx:showNotification("Wiadomość")
        message = tostring(args[1])
    elseif args.n >= 2 then
        -- Sprawdzamy, czy drugi argument to rozpoznawalny typ
        if typeToIconMap[tostring(args[2])] then
            -- Przypadek 2: esx:showNotification("Wiadomość", "error")
            message = tostring(args[1])
            icon = typeToIconMap[tostring(args[2])]
        else
            -- Przypadek 3: Domyślnie traktujemy jako ("Tytuł", "Wiadomość")
            title = tostring(args[1])
            message = tostring(args[2])
        end
    end

    -- Wywołujemy nową funkcję `notification` z przetłumaczonymi danymi
    notification(icon, "System", title, message, time, nil)
end

-- Przechwytujemy stare eventy i exporty, kierując je do naszego tłumacza
RegisterNetEvent('esx:showNotification', showCompatibilityNotification)
RegisterNetEvent('jules-notify:showNotification', showCompatibilityNotification) -- Dla pewności
exports('Notify', showCompatibilityNotification) -- Dla kompatybilności z `es_extended`
