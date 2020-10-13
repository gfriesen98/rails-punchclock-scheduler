class AddNameToShifts < ActiveRecord::Migration[6.0]
  def change
    add_column :shifts, :name, :string
  end
end
