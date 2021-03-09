# frozen_string_literal: true

Sequel.migration do
  up do
    create_table :task_assignments do
      primary_key :id, type: Bignum

      foreign_key :task_id, :tasks, type: 'bigint', null: false, key: [:id]
      foreign_key :user_id, :users, type: 'bigint', null: false, key: [:id]
      column :created_at, 'timestamp(6) without time zone', null: false
      column :updated_at, 'timestamp(6) without time zone', null: false

      index [:task_id], name: :index_user_sessions_on_user_id
      index [:user_id], name: :index_user_sessions_on_uuid
    end
  end

  down do
    drop_table :task_assignments
  end
end
