class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.references :user, index: true, foreign_key: true
      t.text :content, limit: 4294967295

      t.timestamps null: false
    end
  end
end
