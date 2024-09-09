import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  changeBackgroundColor() {
    let color = "pink";
    this.element.classList.add(`bg-${color}-200`)
  }
}
