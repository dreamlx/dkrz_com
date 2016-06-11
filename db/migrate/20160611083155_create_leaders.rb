class CreateLeaders < ActiveRecord::Migration
  def change
    create_table :leaders do |t|
      t.string :name
      t.string :phone
      t.string :sex
      t.date :birth
      t.string :workplace
      t.string :income
      t.string :payoff_type
      t.string :job
      t.string :has_credit_card
      t.string :loan_experience
      t.string :mortgage
      t.string :has_car_loan
      t.string :has_accumulation_fund
      t.string :has_life_insurance
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
