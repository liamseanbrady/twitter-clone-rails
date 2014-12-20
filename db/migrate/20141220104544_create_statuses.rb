class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.column :body, :text
      t.column :user_id, :integer

      t.timestamps
    end
  end
end
