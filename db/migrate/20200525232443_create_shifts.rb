class CreateShifts < ActiveRecord::Migration[6.0]
  def change
    create_table :shifts do |t|
      t.string :user_id
      t.datetime :start_time
      t.datetime :end_time
      t.datetime :date_scheduled

      t.timestamps
    end
  end
end
