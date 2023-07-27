class Seat < ApplicationRecord
  belongs_to :reservation

  enum status: { free: 'free', selected: 'selected', reserved: 'reserved' }

  validates :status, presence: true, inclusion: { in: statuses.keys.map(&:to_s) }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validate :validate_status_change, if: :will_save_change_to_status?

  after_update_commit -> { broadcast_replace_to(:seats, target: "seat_#{id}", locals: { seat: self, reservation: self.reservation }) }

  private

  def validate_status_change
    if status_changed? && (status_was == 'reserved' ||
      status_was == 'selected' && reservation_id != reservation_id_was)
      errors.add(:status, "cannot be changed when the seat is already reserved")
    end
  end
end
