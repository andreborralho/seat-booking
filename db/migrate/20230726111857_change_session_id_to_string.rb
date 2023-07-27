class ChangeSessionIdToString < ActiveRecord::Migration[7.0]
  def change
    change_column :reservations, :session_id, :string
  end
end
