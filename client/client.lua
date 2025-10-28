ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

-- Przechwytywanie standardowych powiadomień ESX
RegisterNetEvent('esx:showNotification')
AddEventHandler('esx:showNotification', function(message)
    SendNUIMessage({
        action = 'showNotification',
        title = 'Powiadomienie', -- Domyślny tytuł
        message = message,
        type = 'info'
    })
end)

-- Zaktualizowany event do wysyłania powiadomień z tytułem i treścią
RegisterNetEvent('jules-notify:showNotification')
AddEventHandler('jules-notify:showNotification', function(data)
    SendNUIMessage({
        action = 'showNotification',
        title = data.title or 'Powiadomienie',
        message = data.message or 'Brak treści.',
        type = data.type or 'info'
    })
end)
