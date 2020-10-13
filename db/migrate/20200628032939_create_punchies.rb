class CreatePunchies < ActiveRecord::Migration[6.0]
  def change
    create_table :punchies do |t|
      t.string :user_id
      t.string :name
      t.datetime :timePunchIn
      t.datetime :timePunchOut

      t.timestamps
    end
  end
end
