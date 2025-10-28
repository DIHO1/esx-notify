document.addEventListener('DOMContentLoaded', () => {
    const container = document.getElementById('notification-container');

    const icons = {
        success: 'fa-solid fa-check-circle',
        error: 'fa-solid fa-times-circle',
        warning: 'fa-solid fa-exclamation-triangle',
        info: 'fa-solid fa-info-circle'
    };

    window.addEventListener('message', (event) => {
        const data = event.data;

        if (data.action === 'showNotification') {
            createNotification(data.title, data.message, data.type);
        }
    });

    function createNotification(title, message, type = 'info') {
        const notif = document.createElement('div');
        notif.classList.add('notification', type);

        const iconClass = icons[type] || icons.info;

        notif.innerHTML = `
            <div class="icon">
                <i class="${iconClass}"></i>
            </div>
            <div class="content">
                <p class="title">${title || 'Powiadomienie'}</p>
                <p class="message">${message || 'Brak treści.'}</p>
            </div>
            <div class="progress-bar"></div>
        `;

        container.appendChild(notif);

        // Pokaż powiadomienie
        setTimeout(() => {
            notif.classList.add('show');
        }, 100);

        // Ukryj i usuń powiadomienie po 5 sekundach
        setTimeout(() => {
            notif.classList.remove('show');
            // Usuń element z DOM po zakończeniu animacji
            notif.addEventListener('transitionend', () => notif.remove());
        }, 5000);
    }
});
