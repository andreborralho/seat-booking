import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["seat", "price", "quantity"];

  connect() {
    this.selectedSeats = [];
    this.calculateTotal();
    document.addEventListener('turbo:before-stream-render', this.afterStreamRender);
  }

  disconnect() {
    document.removeEventListener('turbo:before-stream-render', this.afterStreamRender);
  }

  afterStreamRender = (event) => {
    console.log(event)
    const seatElements = this.element.querySelectorAll('.own-selected .seat.selected');
    console.log(seatElements);

    seatElements.forEach((seatElement) => {
      const buttonElement = seatElement.closest('button');
      buttonElement.removeAttribute('disabled');
    });

  }

  selectSeat(event) {
    const seat = event.currentTarget;
    if (seat.closest('td').classList.contains("own-selected")) {
      this.selectedSeats = this.selectedSeats.filter(
        (selectedSeat) => selectedSeat.dataset.id !== seat.dataset.id
      );
    } else {
      seat.closest('td').classList.add("own-selected");
      this.selectedSeats.push(seat);
    }
    this.calculateTotal();
  }

  calculateTotal() {
    const total = this.selectedSeats.reduce((sum, seat) => {
      const price = parseFloat(seat.dataset.price);
      return sum + price;
    }, 0);

    this.priceTarget.textContent = '€ ' + total.toFixed(2);
    this.quantityTarget.textContent = this.selectedSeats.length;
  }

  clearTotals() {
    this.priceTarget.textContent = '0.00 €';
    this.quantityTarget.textContent = '0';
  }
}