-- Ten plik jest po stronie serwera.
-- Główna logika znajduje się w client/client.lua

-- Komenda do łatwego testowania nowego systemu powiadomień
RegisterCommand('testnotify', function(source, args, rawCommand)
    local src = source

    -- Wywołujemy nowe, niestandardowe zdarzenie, aby pokazać pełne możliwości
    TriggerClientEvent('notification:show', src,
        'fab fa-twitter text-info', -- Ikona (Font Awesome + kolor Bootstrap)
        'Twitter', -- Nazwa aplikacji
        'Nowe Powiadomienie!', -- Tytuł
        'Witaj w nowym systemie powiadomień w stylu iOS! Mamy nadzieję, że Ci się podoba.', -- Treść wiadomości
        10000, -- Czas wyświetlania w milisekundach (10 sekund)
        'not1' -- Dźwięk (opcjonalnie, np. 'not1', 'not2' lub 'default')
    )

    -- Testujemy również starą metodę, aby sprawdzić kompatybilność
    TriggerClientEvent('esx:showNotification', src, 'To jest test starego systemu!', 'success')
end, false)
