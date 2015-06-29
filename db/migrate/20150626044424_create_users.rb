class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :off_day

      t.timestamps null: false
    end
  end
end
