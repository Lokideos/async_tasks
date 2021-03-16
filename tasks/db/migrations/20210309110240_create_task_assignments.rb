# frozen_string_literal: true

Sequel.migration do
  up do
    create_table :task_assignments do
      primary_key :id, type: Bignum

      foreign_key :task_id, :tasks, type: 'bigint', null: false, key: [:id]
      foreign_key :user_id, :users, type: 'bigint', null: false, key: [:id]
      column :created_at, 'timestamp(6) without time zone', null: false
      column :updated_at, 'timestamp(6) without time zone', null: false

      index [:task_id], name: :index_task_assignments_on_task_id, unique: true
      index [:user_id], name: :index_task_assignments_on_user_id
    end
  end

  down do
    drop_table :task_assignments
  end
end
