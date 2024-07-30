import { Controller } from "@hotwired/stimulus"
import HelloSign from "hellosign-embedded";

// Connects to data-controller="hellosign"
export default class extends Controller {
  static values = {
    clientId: String,
    claimUrl: String,
    redirectPath: String
  }

  connect() {
    this.client = new HelloSign({
      clientId: this.clientIdValue,
      skipDomainVerification: true,
      locale: HelloSign.locales.FR_FR,
      container: document.getElementById('sign-here'),
      allowCancel: false
    });
    this.client.open(this.claimUrlValue);
    this.client.on('sign', (_data) => {
      window.location.href = this.redirectPathValue;
    });
  }
}
