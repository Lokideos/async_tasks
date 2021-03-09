Sequel.migration do
  change do
    create_table(:schema_migrations) do
      column :filename, "text", :null=>false
      
      primary_key [:filename]
    end
    
    create_table(:tasks) do
      primary_key :id
      column :title, "text", :null=>false
      column :description, "text", :null=>false
      column :status, "text", :null=>false
      column :created_at, "timestamp(6) without time zone", :null=>false
      column :updated_at, "timestamp(6) without time zone", :null=>false
    end
    
    create_table(:users) do
      primary_key :id
      column :name, "text", :null=>false
      column :role, "text", :null=>false
      column :created_at, "timestamp(6) without time zone", :null=>false
      column :updated_at, "timestamp(6) without time zone", :null=>false
    end
    
    create_table(:task_assignments) do
      primary_key :id
      foreign_key :task_id, :tasks, :type=>"bigint", :null=>false, :key=>[:id]
      foreign_key :user_id, :users, :type=>"bigint", :null=>false, :key=>[:id]
      column :created_at, "timestamp(6) without time zone", :null=>false
      column :updated_at, "timestamp(6) without time zone", :null=>false
      
      index [:task_id], :name=>:index_user_sessions_on_user_id
      index [:user_id], :name=>:index_user_sessions_on_uuid
    end
  end
end
