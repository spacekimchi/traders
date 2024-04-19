function addCopyToClipboardWithNotificationEvent(element) {
    element.addEventListener('mousedown', function(event) {
        if (event.button === 0) {
            const text = this.innerText;
            navigator.clipboard.writeText(text).then(function() {
                let mouseNotification = document.getElementById('mouse-notification');
                mouseNotification.style.left = event.pageX + 15 + 'px';
                mouseNotification.style.top = event.pageY - 10 + 'px';
                mouseNotification.style.display = 'block';
                mouseNotification.style.opacity = 1;

                setTimeout(() => {
                    mouseNotification.style.opacity = 0;

                    setTimeout(() => {
                        mouseNotification.style.display = 'none';
                    }, 300);
                }, 800);
            }, function(err) {
                console.error('Could not copy text: ', err);
            });
        }
    });
}
