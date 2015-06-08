class CreateSchoolDays < ActiveRecord::Migration
  def change
    create_table :school_days do |t|
      t.date :date

      t.timestamps null: false
    end
    change_table :attendances do |t|
      t.references :school_day, index: true, foreign_key: true
    end
    remove_column :attendances, :date, :date
  end
end
