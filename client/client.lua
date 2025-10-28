ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

--[[
    Super Inteligentny Tłumacz Powiadomień (Wersja Ostateczna)
    Ta funkcja jest odporna na różne, nawet nietypowe formaty wywołań
    ze starych i niestandardowych skryptów.
]]
local function showSuperIntelligentNotification(...)
    local args = table.pack(...)
    local data = {}
    local validTypes = { success = true, error = true, warning = true, info = true }

    -- Case 1: Nowoczesne wywołanie z jedną tabelą danych (najlepszy przypadek)
    if args.n == 1 and type(args[1]) == 'table' then
        data = args[1]
    else -- Case 2: Starsze wywołania z pojedynczymi argumentami
        if args.n == 1 then
            -- Jeden argument to ZAWSZE treść wiadomości.
            data.message = tostring(args[1])
        elseif args.n == 2 then
            local arg1 = tostring(args[1])
            local arg2 = tostring(args[2])
            -- Sprawdzamy, czy drugi argument jest liczbą (czyli czasem trwania)
            if tonumber(arg2) then
                -- Jeśli tak, to pierwszy argument jest treścią, a drugi ignorujemy.
                data.message = arg1
            -- Sprawdzamy, czy drugi argument jest prawidłowym typem
            elseif validTypes[arg2] then
                -- Jeśli tak, to mamy (treść, typ).
                data.message = arg1
                data.type = arg2
            else
                -- W każdym innym przypadku, traktujemy to jako (tytuł, treść).
                data.title = arg1
                data.message = arg2
            end
        elseif args.n >= 3 then
            -- Trzy lub więcej argumentów to prawie zawsze (tytuł, treść, typ).
            data.title = tostring(args[1])
            data.message = tostring(args[2])
            data.type = tostring(args[3])
        end
    end

    -- Ostateczne ustawienie wartości domyślnych, aby NUI nigdy nie otrzymało pustych danych.
    data.action = 'showNotification'
    data.title = data.title or 'Powiadomienie'
    data.message = data.message or 'Brak treści.'
    data.type = data.type or 'info'

    SendNUIMessage(data)
end

-- Wszystkie drogi prowadzą do naszego nowego, inteligentnego "tłumacza"
RegisterNetEvent('esx:showNotification', showSuperIntelligentNotification)
RegisterNetEvent('jules-notify:showNotification', showSuperIntelligentNotification)
exports('Notify', showSuperIntelligentNotification)
