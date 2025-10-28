-- Rejestracja komendy do testowania powiadomień
RegisterCommand('testnotify', function(source, args, rawCommand)
    local src = source

    -- Powiadomienie o sukcesie
    TriggerClientEvent('jules-notify:showNotification', src, {
        message = 'To jest testowe powiadomienie o sukcesie!',
        type = 'success'
    })

    -- Odczekaj chwilę przed wysłaniem kolejnego powiadomienia
    Citizen.Wait(1000)

    -- Powiadomienie o błędzie
    TriggerClientEvent('jules-notify:showNotification', src, {
        message = 'Uwaga! Wystąpił błąd.',
        type = 'error'
    })

    Citizen.Wait(1000)

    -- Powiadomienie informacyjne
    TriggerClientEvent('jules-notify:showNotification', src, {
        message = 'To jest zwykła informacja dla Ciebie.',
        type = 'info'
    })

    Citizen.Wait(1000)

    -- Powiadomienie ostrzegawcze
    TriggerClientEvent('jules-notify:showNotification', src, {
        message = 'Lepiej uważaj, to jest ostrzeżenie.',
        type = 'warning'
    })

end, false) -- false oznacza, że komenda nie jest zablokowana dla graczy
