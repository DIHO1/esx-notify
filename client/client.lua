ESX = nil

-- Pobranie obiektu ESX
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

-- Przechwytywanie standardowych powiadomień ESX
RegisterNetEvent('esx:showNotification')
AddEventHandler('esx:showNotification', function(message)
    -- Domyślnie wysyłamy powiadomienie jako typ 'info'
    SendNUIMessage({
        action = 'showNotification',
        message = message,
        type = 'info'
    })
end)

-- Nowy event do wysyłania powiadomień z określonym typem
RegisterNetEvent('jules-notify:showNotification')
AddEventHandler('jules-notify:showNotification', function(data)
    local message = data.message or 'Brak wiadomości'
    local type = data.type or 'info' -- Dostępne typy: success, error, warning, info

    SendNUIMessage({
        action = 'showNotification',
        message = message,
        type = type
    })
end)
