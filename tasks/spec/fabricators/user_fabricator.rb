# frozen_string_literal: true

Fabricator(:user) do
  name { sequence { |n| "user_name_#{n}" } }
  role { 'developer' }
end
