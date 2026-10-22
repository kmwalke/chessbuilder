self.addEventListener("push", async (event) => {
    const data = event.data.json();

    event.waitUntil(
        self.registration.showNotification(data.title, {
            body: data.body,
            icon: "/logo.png"
        })
    );
})

self.addEventListener("notificationclick", function(event) {
  event.notification.close()
  event.waitUntil(
    clients.matchAll({ type: "window" }).then((clientList) => {
      for (let i = 0; i < clientList.length; i++) {
        let client = clientList[i]
        let clientPath = (new URL(client.url)).pathname

        if (clientPath == event.notification.data.path && "focus" in client) {
          return client.focus() && window.location.reload()
        }
      }

      if (clients.openWindow) {
        return clients.openWindow(event.notification.data.path) && window.location.reload()
      }
    })
  )
})
