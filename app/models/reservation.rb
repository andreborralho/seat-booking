class Reservation < ApplicationRecord
  has_many :seats

  validates :session_id, presence: true
end
