class CreateInboxes < ActiveRecord::Migration
  def self.up
    create_table :inboxes do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :inboxes
  end
end
