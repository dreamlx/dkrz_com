class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.references :user, index: true, foreign_key: true
      t.decimal :amount, precision: 12, scale: 2, default: 0
      t.references :recordable, polymorphic: true, index: true
      t.decimal :from_amount, precision: 12, scale: 2, default: 0
      t.decimal :to_amount, precision: 12, scale: 2, default: 0
      t.date :date
      t.string :desc

      t.timestamps null: false
    end
  end
end
