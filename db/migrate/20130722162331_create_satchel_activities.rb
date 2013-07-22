class CreateSatchelActivities < ActiveRecord::Migration
  def change
    create_table :satchel_activities do |t|
      t.integer :user_id
      t.string :subject_type, index: true, null: false
      t.string :subject_id, index: true, null: false
      t.string :activity_type, index: true, null: false
      t.text :message
      t.timestamps
    end
    add_index :satchel_activities, :user_id
  end
end
