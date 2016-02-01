class CreateQueuedTasks < ActiveRecord::Migration
  def change
    create_table :queued_tasks do |t|
      t.string :klass
      t.text :data
      t.boolean :locked

      t.timestamps null: false
    end

    add_index :queued_tasks, :locked
  end
end
