document.addEventListener('DOMContentLoaded', () => {
    const container = document.getElementById('notification-container');

    window.addEventListener('message', (event) => {
        const data = event.data;

        if (data.action === 'showNotification') {
            createNotification(data.message, data.type);
        }
    });

    function createNotification(message, type = 'info') {
        const notif = document.createElement('div');
        notif.classList.add('notification', type);
        notif.textContent = message;

        container.appendChild(notif);

        // Pokaż powiadomienie
        setTimeout(() => {
            notif.classList.add('show');
        }, 100);

        // Ukryj i usuń powiadomienie po 5 sekundach
        setTimeout(() => {
            notif.classList.remove('show');
            notif.classList.add('hide');

            // Usuń element z DOM po zakończeniu animacji
            notif.addEventListener('transitionend', () => {
                notif.remove();
            });
        }, 5000);
    }
});
