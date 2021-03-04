# frozen_string_literal: true

Sequel.migration do
  up do
    create_table :tasks do
      primary_key :id, type: Bignum

      column :title, String, null: false
      column :description, String, null: false
      column :status, String, null: false
      column :created_at,  "timestamp(6) without time zone", null: false
      column :updated_at,  "timestamp(6) without time zone", null: false
    end
  end

  down do
    drop_table :tasks
  end
end
