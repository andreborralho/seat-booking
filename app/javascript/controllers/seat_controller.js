import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['seat', 'price', 'quantity'];

  connect() {
    this.selectedSeats = [];
    this.calculateTotal();
    document.addEventListener('turbo:before-stream-render', this.handleBeforeStreamRender.bind(this));
  }

  disconnect() {
    document.removeEventListener('turbo:before-stream-render', this.handleBeforeStreamRender.bind(this));
  }

  handleBeforeStreamRender(event) {
    event.preventDefault();
    event.detail.newStream.performAction();
    this.afterStreamRender();
  }

  afterStreamRender() {
    const seatElements = this.element.querySelectorAll('.own-selected button');
    seatElements.forEach((seatElement) => {
      const buttonElement = seatElement.closest('button');
      buttonElement.removeAttribute('disabled');
    });
  }

  selectSeat(event) {
    const seat = event.currentTarget.querySelector('.seat');
    if (seat.closest('td').classList.contains('own-selected')) {
      seat.closest('td').classList.remove('own-selected');
      this.selectedSeats = this.selectedSeats.filter(
        (selectedSeat) => selectedSeat.dataset.id !== seat.dataset.id
      );
    } else {
      seat.closest('td').classList.add('own-selected');
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
    const elements = this.element.querySelectorAll('.own-selected');
    elements.forEach((element) => {
      element.classList.remove('own-selected');
    });
    this.selectedSeats = [];
  }
}