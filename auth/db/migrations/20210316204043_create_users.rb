# frozen_string_literal: true

Sequel.migration do
  up do
    extension :pg_enum

    create_enum(:user_roles_enum, %w'developer manager admin')

    create_table(:users) do
      primary_key :id, type: :Bignum
      column :name, 'character varying', null: false
      column :email, 'citext', null: false
      column :role, 'user_roles_enum', null: false
      column :password_digest, 'character varying', null: false
      column :created_at, 'timestamp(6) without time zone', null: false
      column :updated_at, 'timestamp(6) without time zone', null: false

      index [:email], name: :index_users_on_email, unique: true
    end
  end

  down do
    extension :pg_enum

    drop_table(:users)
    drop_enum(:user_roles_enum)
  end
end
