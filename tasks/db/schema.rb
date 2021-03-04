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
  end
end
