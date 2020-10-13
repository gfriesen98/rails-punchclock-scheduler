class RemoveDateScheduledFromShifts < ActiveRecord::Migration[6.0]
  def change
    remove_column :shifts, :date_scheduled, :datetime
  end
end
