class CreateMentions < ActiveRecord::Migration
  def change
    create_table :mentions do |t|
      t.column :user_id, :integer
      t.column :status_id, :integer

      t.timestamps
    end
  end
end
