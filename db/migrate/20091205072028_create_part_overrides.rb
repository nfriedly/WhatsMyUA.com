class CreatePartOverrides < ActiveRecord::Migration
  def self.up
    create_table :part_overrides do |t|
      t.integer :part_id
      t.integer :override_part_id

      t.timestamps
    end
  end

  def self.down
    drop_table :part_overrides
  end
end
