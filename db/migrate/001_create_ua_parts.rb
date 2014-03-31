class CreateUaParts < ActiveRecord::Migration
  def self.up
    create_table :ua_parts do |t|
       t.string :key, :unique => true, :null => false
	t.string :description
	t.string :part_type
	t.boolean :named_version, :null => false, :default => false
	t.string :split_on, :null => true
	t.string :split_before, :null => true
    end

	create_table :ua_overrides do |t|
		t.integer :part_id, :null => false
		t.integer ::overrides_part_id, :null => false
	enc
  end

  def self.down
    drop_table :ua_parts
	drop_table :ua_overrides
  end
end
