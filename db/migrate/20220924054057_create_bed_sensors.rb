class CreateBedSensors < ActiveRecord::Migration[7.0]
  def change
    create_table :bed_sensors do |t|
      t.string :name
      t.boolean :is_active

      t.timestamps
    end
  end
end
