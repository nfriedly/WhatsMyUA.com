class CreateUserAgents < ActiveRecord::Migration
  def self.up
    create_table :user_agents do |t|
      t.string :user_agent, :unique => true
      t.int :hits, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :user_agents
  end
end
