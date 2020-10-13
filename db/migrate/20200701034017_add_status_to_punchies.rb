class AddStatusToPunchies < ActiveRecord::Migration[6.0]
  def change
    add_column :punchies, :status, :string
  end
end
