ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

--[[
    Uniwersalna funkcja do obsługi powiadomień.
    Inteligentnie analizuje otrzymane argumenty, aby zapewnić kompatybilność
    zarówno ze starymi, jak i nowymi skryptami.
]]
local function showUniversalNotification(...)
    local args = table.pack(...)
    local data = {}

    -- Case 1: Argumenty przekazane jako pojedyncza tabela (np. z naszego nowego eventu)
    if args.n == 1 and type(args[1]) == 'table' then
        data = args[1]
    else -- Case 2: Argumenty przekazane jako osobne parametry (np. z eksportu lub starych eventów)
        if args.n == 1 then
            -- Pojedynczy argument to zawsze TREŚĆ wiadomości (np. "Pasy zapięte")
            data.message = tostring(args[1])
        elseif args.n == 2 then
            -- Dwa argumenty mogą oznaczać (treść, typ) lub (tytuł, treść).
            -- Sprawdzamy, czy drugi argument wygląda jak prawidłowy typ.
            local validTypes = { success = true, error = true, warning = true, info = true }
            if validTypes[tostring(args[2])] then
                -- Jeśli tak, to jest to (treść, typ)
                data.message = tostring(args[1])
                data.type = tostring(args[2])
            else
                -- Jeśli nie, to jest to (tytuł, treść)
                data.title = tostring(args[1])
                data.message = tostring(args[2])
            end
        elseif args.n >= 3 then
            -- Trzy lub więcej argumentów to zawsze (tytuł, treść, typ)
            data.title = tostring(args[1])
            data.message = tostring(args[2])
            data.type = tostring(args[3])
        end
    end

    -- Ustawienie wartości domyślnych, aby uniknąć błędów
    data.action = 'showNotification'
    data.title = data.title or 'Powiadomienie'
    data.message = data.message or 'Brak treści.'
    data.type = data.type or 'info'

    SendNUIMessage(data)
end

-- Przechwytywanie standardowych powiadomień ESX (stary system)
RegisterNetEvent('esx:showNotification')
AddEventHandler('esx:showNotification', showUniversalNotification)

-- Zaktualizowany event do wysyłania powiadomień (nowy system, z tabelą)
RegisterNetEvent('jules-notify:showNotification')
AddEventHandler('jules-notify:showNotification', showUniversalNotification)

-- Zaktualizowany eksport, który teraz obsługuje wszystkie możliwe formaty wywołań
exports('Notify', showUniversalNotification)
