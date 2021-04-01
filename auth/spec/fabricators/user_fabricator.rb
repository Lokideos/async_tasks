# frozen_string_literal: true

Fabricator(:user) do
  name { sequence { |n| "name_#{n}" } }
  email { sequence { |n| "email_#{n}" } }
  role { User::ADMIN_ROLE }
  password { sequence { |n| "password_#{n}" } }
end
