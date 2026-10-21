import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    async subscribe(event) {
        const registration = await navigator.serviceWorker.ready;

        const subscription = await registration.pushManager.subscribe({
            userVisibleOnly: true,
            applicationServerKey: window.vapidPublicKey
        });

        await fetch("users/" + event.params.id + "/web_push_subscription", {
            method: "POST",
            headers: { "Content-Type": "application/json", "X-CSRF-Token": document.querySelector("[name='csrf-token']").content },
            body: JSON.stringify(subscription)
        });

        alert("Notifications Enabled!");
    }
}