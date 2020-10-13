class CreatePunches < ActiveRecord::Migration[6.0]
  def change
    create_table :punches do |t|
      t.string :user_id
      t.string :name
      t.datetime :timePunchedIn
      t.datetime :timePunchedOut

      t.timestamps
    end
  end
end
