class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.column :follower_id, :integer
      t.column :leader_id, :integer

      t.timestamps
    end
  end
end
