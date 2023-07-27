import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["seat", "total"];

  connect() {
    this.selectedSeats = [];
    this.calculateTotal();
  }

  selectSeat(event) {
    const seat = event.currentTarget;
    if (seat.classList.contains("own-selected")) {
      console.log(seat);
      console.log("remove seat");
      this.selectedSeats = this.selectedSeats.filter(
        (selectedSeat) => selectedSeat !== seat
      );
    } else {
      console.log(seat);
      console.log("add seat");
      //seat.classList.remove("own-selected");
      this.selectedSeats.push(seat);
    }

    this.calculateTotal();
  }

  calculateTotal() {
    console.log(this.selectedSeats);
    const total = this.selectedSeats.reduce((sum, seat) => {
      const price = parseFloat(seat.dataset.price);
      return sum + price;
    }, 0);

    this.totalTarget.textContent = total.toFixed(2);
  }
}