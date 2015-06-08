class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.date :date
      t.references :student, index: true, foreign_key: true
      t.boolean :present

      t.timestamps null: false
    end
  end
end
