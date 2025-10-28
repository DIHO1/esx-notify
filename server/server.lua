-- Zaktualizowana komenda do testowania nowych powiadomień
RegisterCommand('testnotify', function(source, args, rawCommand)
    local src = source

    local notifications = {
        {
            title = 'Sukces',
            message = 'Operacja zakończyła się pomyślnie. Gratulacje!',
            type = 'success'
        },
        {
            title = 'Błąd Krytyczny',
            message = 'Nie udało się połączyć z serwerem. Sprawdź swoje połączenie.',
            type = 'error'
        },
        {
            title = 'Informacja',
            message = 'Serwer zostanie zrestartowany za 15 minut. Zapisz swoje postępy.',
            type = 'info'
        },
        {
            title = 'Ostrzeżenie',
            message = 'Twoje konto bankowe jest na minusie. Spłać dług jak najszybciej.',
            type = 'warning'
        }
    }

    -- Pętla do wysyłania powiadomień co sekundę
    Citizen.CreateThread(function()
        for _, data in ipairs(notifications) do
            TriggerClientEvent('jules-notify:showNotification', src, data)
            Citizen.Wait(1000)
        end
    end)

end, false)
