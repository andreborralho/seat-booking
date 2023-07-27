class RemoveUsers < ActiveRecord::Migration[7.0]
  def up
    remove_foreign_key :reservations, :users

    drop_table :users
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
