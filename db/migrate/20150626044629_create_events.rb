class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :date
      t.belongs_to :user

      t.timestamps null: false
    end
  end
end
