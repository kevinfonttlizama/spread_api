class CreateAlertSpreads < ActiveRecord::Migration[7.1]
  def change
    create_table :alert_spreads do |t|
      t.float :value

      t.timestamps
    end
  end
end
