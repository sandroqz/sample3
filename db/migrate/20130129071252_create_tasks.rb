class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :owner
      t.string :tags
      t.text :description
      t.datetime :completed_at

      t.timestamps
    end
  end
end
