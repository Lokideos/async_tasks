# frozen_string_literal: true

Sequel.migration do
  up do
    create_table :users do
      primary_key :id, type: Bignum

      column :name, String, null: false
      column :role, String, null: false
      column :created_at,  "timestamp(6) without time zone", null: false
      column :updated_at,  "timestamp(6) without time zone", null: false
    end
  end

  down do
    drop_table :users
  end
end
